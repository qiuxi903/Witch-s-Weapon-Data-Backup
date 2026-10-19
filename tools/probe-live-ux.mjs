// 线上站点「用户实际会看到什么」实测（修正版）
//   node tools/probe-live-ux.mjs [CDP端口] [站点根URL]
const PORT = process.argv[2] || '9223';
const BASE = (process.argv[3] || 'https://witchweapon.hutaomu.cn/').replace(/\/$/, '') + '/';

const list = await (await fetch(`http://127.0.0.1:${PORT}/json/list`)).json();
const target = list.find(t => t.type === 'page');
if (!target) { console.error('没有可用的页面目标'); process.exit(2); }
const ws = new WebSocket(target.webSocketDebuggerUrl);
let id = 0; const pending = new Map();
ws.addEventListener('message', ev => {
  const m = JSON.parse(ev.data);
  if (m.id && pending.has(m.id)) {
    const { resolve, reject } = pending.get(m.id); pending.delete(m.id);
    m.error ? reject(new Error(JSON.stringify(m.error))) : resolve(m.result);
  }
});
function send(method, params = {}) {
  return new Promise((resolve, reject) => {
    const myId = ++id; pending.set(myId, { resolve, reject });
    ws.send(JSON.stringify({ id: myId, method, params }));
    setTimeout(() => { if (pending.has(myId)) { pending.delete(myId); reject(new Error('timeout ' + method)); } }, 90000);
  });
}
const sleep = ms => new Promise(r => setTimeout(r, ms));
await new Promise(r => ws.addEventListener('open', r));
await send('Page.enable'); await send('Runtime.enable');

async function go(page, expr, wait = 3500) {
  await send('Page.navigate', { url: BASE + page });
  await sleep(wait);
  const r = await send('Runtime.evaluate', { expression: expr, awaitPromise: true, returnByValue: true });
  return r.result.value;
}
const out = [];
function line(s) { out.push(s); console.log(s); }

// 通用：点开画廊第一张，看灯箱原图
const LIGHTBOX = `(async () => {
  const fig = document.querySelector('figure.gal-item[data-full]');
  if (!fig) return JSON.stringify({ 错误: '页面上没有 figure.gal-item[data-full]' });
  const full = fig.getAttribute('data-full');
  const thumbImg = fig.querySelector('img');
  fig.click();
  await new Promise(r => setTimeout(r, 5000));
  const big = document.querySelector('.lb img, .lightbox img, #lb img, .lbimg, [class*=lb] img');
  const all = [...document.querySelectorAll('img')].filter(i => i.getAttribute('src') === full);
  const probe = all[0] || big;
  return JSON.stringify({
    原图URL: full,
    缩略图是否正常: thumbImg ? (thumbImg.complete && thumbImg.naturalWidth > 0) : null,
    灯箱元素是否出现: !!big,
    灯箱图片naturalWidth: probe ? probe.naturalWidth : null,
    灯箱图片是否裂: probe ? (probe.complete && probe.naturalWidth === 0) : null,
  }, null, 1);
})()`;

for (const [page, label] of [['art.html', '美术页'], ['characters.html', '角色页'], ['manga.html', '四格漫画页']]) {
  line(`=== ${label} ${page}：点开一张图看灯箱 ===`);
  line(await go(page, LIGHTBOX, 4000));
  line('');
}

// 音频：强制加载前 3 个播放器
line('=== 音频页 audio.html：强制加载前 3 个播放器 ===');
line(await go('audio.html', `(async () => {
  document.querySelectorAll('details').forEach(d => d.open = true);
  await new Promise(r => setTimeout(r, 5000));
  const auds = [...document.querySelectorAll('audio[src]')].slice(0, 3);
  auds.forEach(a => { a.preload = 'auto'; a.load(); });
  await new Promise(r => setTimeout(r, 6000));
  return JSON.stringify({
    测试数量: auds.length,
    结果: auds.map(a => ({
      src: a.getAttribute('src').slice(-46),
      readyState: a.readyState,
      networkState: a.networkState,
      error: a.error ? ('code ' + a.error.code + ' ' + (a.error.message || '')) : null,
      duration: a.duration,
    })),
  }, null, 1);
})()`, 4000));

// 视频：强制加载前 2 个
line('');
line('=== 视频页 video.html：强制加载前 2 个 ===');
line(await go('video.html', `(async () => {
  document.querySelectorAll('details').forEach(d => d.open = true);
  await new Promise(r => setTimeout(r, 5000));
  const vs = [...document.querySelectorAll('video[src]')].slice(0, 2);
  vs.forEach(v => { v.preload = 'auto'; v.load(); });
  await new Promise(r => setTimeout(r, 8000));
  return JSON.stringify({
    测试数量: vs.length,
    结果: vs.map(v => ({
      src: v.getAttribute('src').slice(-40),
      readyState: v.readyState,
      networkState: v.networkState,
      error: v.error ? ('code ' + v.error.code + ' ' + (v.error.message || '')) : null,
      duration: v.duration,
    })),
  }, null, 1);
})()`, 4000));

// 全站图片强制加载（把 loading=lazy 去掉并滚动）
line('');
line('=== 各页强制加载全部图片后的失败数 ===');
for (const p of ['index.html', 'story.html', 'characters.html', 'art.html', 'manga.html']) {
  const r = await go(p, `(async () => {
    document.querySelectorAll('details').forEach(d => d.open = true);
    await new Promise(r => setTimeout(r, 1500));
    // 把折叠里的 data-src 全部写入 src
    document.querySelectorAll('img[data-src]').forEach(i => {
      i.src = i.getAttribute('data-src'); i.removeAttribute('data-src');
    });
    document.querySelectorAll('img[loading]').forEach(i => i.removeAttribute('loading'));
    await new Promise(r => setTimeout(r, 12000));
    const imgs = [...document.querySelectorAll('img')];
    const withSrc = imgs.filter(i => i.getAttribute('src'));
    const bad = withSrc.filter(i => i.complete && i.naturalWidth === 0);
    const ok = withSrc.filter(i => i.complete && i.naturalWidth > 0);
    return JSON.stringify({
      图片总数: imgs.length, 已设src: withSrc.length,
      加载成功: ok.length, 加载失败: bad.length,
      失败示例: bad.slice(0, 2).map(i => i.getAttribute('src')),
    });
  })()`, 3000);
  line(`  ${p.padEnd(16)} ${r}`);
}

ws.close();
process.exit(0);

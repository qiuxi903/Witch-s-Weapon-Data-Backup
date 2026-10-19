// 站点浏览器实测：逐页加载 → 展开折叠 → 检查 JS 报错 / 404 / 图片音频是否真的能加载
// 用法：node tools/verify-deploy.mjs [CDP端口] [站点根URL]
//   node tools/verify-deploy.mjs 9223 http://127.0.0.1:8951/   # 部署版
//   node tools/verify-deploy.mjs 9223 http://127.0.0.1:8950/网站/ # 归档版
const PORT = process.argv[2] || '9223';
const BASE = process.argv[3] || 'http://127.0.0.1:8951/';
const PAGES = ['index.html', 'story.html', 'characters.html', 'art.html',
               'manga.html', 'audio.html', 'video.html', 'config.html',
               'system.html', 'news.html', 'relics.html', 'archive.html'];

const list = await (await fetch(`http://127.0.0.1:${PORT}/json/list`)).json();
const target = list.find(t => t.type === 'page');
if (!target) { console.error('没有可用的页面目标'); process.exit(2); }

const ws = new WebSocket(target.webSocketDebuggerUrl);
let id = 0;
const pending = new Map();
let net = [];        // 网络事件
let errs = [];       // JS / 日志错误

ws.addEventListener('message', ev => {
  const m = JSON.parse(ev.data);
  if (m.id && pending.has(m.id)) {
    const { resolve, reject } = pending.get(m.id);
    pending.delete(m.id);
    m.error ? reject(new Error(JSON.stringify(m.error))) : resolve(m.result);
    return;
  }
  if (m.method === 'Network.responseReceived') {
    const r = m.params.response;
    net.push({ kind: 'resp', status: r.status, url: r.url, mime: r.mimeType });
  } else if (m.method === 'Network.loadingFailed') {
    net.push({ kind: 'fail', url: m.params.requestId, err: m.params.errorText,
               canceled: m.params.canceled });
  } else if (m.method === 'Runtime.exceptionThrown') {
    const d = m.params.exceptionDetails;
    errs.push('异常: ' + (d.exception?.description || d.text));
  } else if (m.method === 'Log.entryAdded') {
    const e = m.params.entry;
    if (e.level === 'error') errs.push('日志: ' + e.text + ' @ ' + (e.url || ''));
  }
});

function send(method, params = {}) {
  return new Promise((resolve, reject) => {
    const myId = ++id;
    pending.set(myId, { resolve, reject });
    ws.send(JSON.stringify({ id: myId, method, params }));
    setTimeout(() => { if (pending.has(myId)) { pending.delete(myId); reject(new Error('timeout ' + method)); } }, 120000);
  });
}
const sleep = ms => new Promise(r => setTimeout(r, ms));

await new Promise(r => ws.addEventListener('open', r));
await send('Network.enable');
await send('Page.enable');
await send('Runtime.enable');
await send('Log.enable');

// 展开全部折叠，并等待懒加载资源
const ASSESS = `(() => {
  document.querySelectorAll('details').forEach(d => d.open = true);
  return new Promise(res => setTimeout(() => {
    const imgs = [...document.querySelectorAll('img')];
    const withSrc = imgs.filter(i => i.getAttribute('src'));
    const ok = imgs.filter(i => i.complete && i.naturalWidth > 0);
    const bad = imgs.filter(i => i.complete && i.naturalWidth === 0 && i.getAttribute('src'));
    const srcs = [...document.querySelectorAll('audio source[src], video source[src]')];
    const elSrc = [...document.querySelectorAll('audio[src], video[src]')];
    res(JSON.stringify({
      title: document.title,
      imgs: imgs.length, withSrc: withSrc.length, ok: ok.length,
      badImgs: bad.slice(0, 4).map(i => i.getAttribute('src')),
      sources: srcs.length + elSrc.length,
      bodyLen: document.body.innerText.length,
      sidebar: !!document.querySelector('.side, nav, aside'),
    }));
  }, 4000));
})()`;

let pass = 0, fail = 0;
const report = [];

for (const p of PAGES) {
  net = []; errs = [];
  try {
    await send('Page.navigate', { url: BASE + p });
    await sleep(2500);
    const r = await send('Runtime.evaluate',
      { expression: ASSESS, awaitPromise: true, returnByValue: true });
    const data = JSON.parse(r.result.value);

    const bad = net.filter(x => x.kind === 'resp' && x.status >= 400);
    const netfail = net.filter(x => x.kind === 'fail' && !x.canceled);

    const problems = [];
    if (bad.length) problems.push(`${bad.length} 个 HTTP 错误（首例 ${bad[0].status} ${bad[0].url.slice(-60)}）`);
    if (netfail.length) problems.push(`${netfail.length} 个加载失败（首例 ${netfail[0].err}）`);
    if (data.badImgs.length) problems.push(`${data.badImgs.length} 张图裂（${data.badImgs[0].slice(-50)}）`);
    if (!data.bodyLen) problems.push('页面正文为空');
    if (!data.sidebar) problems.push('缺少侧栏');
    if (errs.length) problems.push(`${errs.length} 条 JS 错误（${errs[0].slice(0, 80)}）`);

    const okImgs = `${data.ok}/${data.imgs} 图`;
    const line = `${problems.length ? 'FAIL' : 'PASS'}  ${p.padEnd(16)} ${data.title.slice(0, 22).padEnd(24)} ${okImgs.padEnd(16)} 媒体 ${String(data.sources).padEnd(5)} 正文 ${data.bodyLen}`;
    report.push(line + (problems.length ? '\n         → ' + problems.join('\n         → ') : ''));
    problems.length ? fail++ : pass++;
  } catch (e) {
    report.push(`FAIL  ${p.padEnd(16)} 测试异常: ${e.message}`);
    fail++;
  }
}

console.log('=== 浏览器实测：' + BASE + ' ===');
console.log(report.join('\n'));
console.log(`\n  结果：${pass} 通过 / ${fail} 失败 / 共 ${PAGES.length} 页`);
ws.close();
process.exit(fail ? 1 : 0);

// 温和版图片实测：分批加载，模拟真实浏览（而不是一次性灌 7000 个请求）
//   node tools/probe-live-images.mjs [CDP端口] [站点根URL]
const PORT = process.argv[2] || '9223';
const BASE = (process.argv[3] || 'https://witchweapon.hutaomu.cn/').replace(/\/$/, '') + '/';
const list = await (await fetch(`http://127.0.0.1:${PORT}/json/list`)).json();
const target = list.find(t => t.type === 'page');
const ws = new WebSocket(target.webSocketDebuggerUrl);
let id = 0; const pending = new Map();
ws.addEventListener('message', ev => {
  const m = JSON.parse(ev.data);
  if (m.id && pending.has(m.id)) { const p = pending.get(m.id); pending.delete(m.id);
    m.error ? p.reject(new Error(JSON.stringify(m.error))) : p.resolve(m.result); }
});
const send = (method, params = {}) => new Promise((resolve, reject) => {
  const myId = ++id; pending.set(myId, { resolve, reject });
  ws.send(JSON.stringify({ id: myId, method, params }));
  setTimeout(() => { if (pending.has(myId)) { pending.delete(myId); reject(new Error('timeout')); } }, 180000);
});
const sleep = ms => new Promise(r => setTimeout(r, ms));
await new Promise(r => ws.addEventListener('open', r));
await send('Page.enable'); await send('Runtime.enable');
const ev = async (expr) => {
  const r = await send('Runtime.evaluate', { expression: expr, awaitPromise: true, returnByValue: true });
  return r.exceptionDetails ? ('JS异常: ' + (r.exceptionDetails.exception?.description || r.exceptionDetails.text)) : r.result.value;
};

for (const page of ['art.html', 'manga.html', 'characters.html']) {
  await send('Page.navigate', { url: BASE + page });
  await sleep(4000);
  // 分批：每次把 150 个 data-src 写入 src，等它们加载完再下一批
  const r = await ev(`(async () => {
    document.querySelectorAll('details').forEach(d => d.open = true);
    await new Promise(r => setTimeout(r, 1200));
    const all = [...document.querySelectorAll('img[data-src]')];
    const BATCH = 150;
    for (let i = 0; i < all.length; i += BATCH) {
      const slice = all.slice(i, i + BATCH);
      slice.forEach(el => { el.src = el.getAttribute('data-src'); el.removeAttribute('data-src'); });
      await new Promise(r => setTimeout(r, 900));
    }
    await new Promise(r => setTimeout(r, 3000));
    const imgs = [...document.querySelectorAll('img')];
    const withSrc = imgs.filter(i => i.getAttribute('src'));
    const bad = withSrc.filter(i => i.complete && i.naturalWidth === 0);
    const ok = withSrc.filter(i => i.complete && i.naturalWidth > 0);
    const pending = withSrc.filter(i => !i.complete);
    return JSON.stringify({
      图片总数: imgs.length, 已设src: withSrc.length,
      加载成功: ok.length, 加载失败: bad.length, 仍在加载: pending.length,
      失败示例: bad.slice(0, 3).map(i => i.getAttribute('src')),
    });
  })()`);
  console.log(`  ${page.padEnd(16)} ${r}`);
}
ws.close(); process.exit(0);

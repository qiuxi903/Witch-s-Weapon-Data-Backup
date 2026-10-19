// 线上视频页：26 个视频逐个强制加载，看哪些能播、哪些不能
//   node tools/probe-live-video.mjs [CDP端口] [站点根URL]
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

await send('Page.navigate', { url: BASE + 'video.html' });
await sleep(4000);
const r = await send('Runtime.evaluate', { awaitPromise: true, returnByValue: true, expression: `(async () => {
  document.querySelectorAll('details').forEach(d => d.open = true);
  await new Promise(r => setTimeout(r, 4000));
  const vs = [...document.querySelectorAll('video[src]')];
  // 逐个加载，避免并发过多
  const results = [];
  for (const v of vs) {
    v.preload = 'auto';
    v.load();
    await new Promise(r => setTimeout(r, 700));
  }
  await new Promise(r => setTimeout(r, 12000));
  for (const v of vs) {
    results.push({
      src: v.getAttribute('src').split('/').pop(),
      readyState: v.readyState,
      error: v.error ? ('code ' + v.error.code) : null,
      duration: v.duration && isFinite(v.duration) ? Math.round(v.duration * 100) / 100 : null,
    });
  }
  const byExt = {};
  for (const x of results) {
    const e = x.src.split('.').pop();
    byExt[e] = byExt[e] || { 总数: 0, 能播: 0, 不能播: 0, 例子: [] };
    byExt[e].总数++;
    if (x.readyState >= 1 && !x.error) byExt[e].能播++;
    else { byExt[e].不能播++; if (byExt[e].例子.length < 3) byExt[e].例子.push(x); }
  }
  return JSON.stringify({ 按格式统计: byExt, 全部结果: results }, null, 1);
})()` });
console.log(r.result.value);
ws.close(); process.exit(0);

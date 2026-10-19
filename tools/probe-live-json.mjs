// 快速验证配置表页的 JSON 导出按钮
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
  setTimeout(() => { if (pending.has(myId)) { pending.delete(myId); reject(new Error('timeout')); } }, 90000);
});
const sleep = ms => new Promise(r => setTimeout(r, ms));
await new Promise(r => ws.addEventListener('open', r));
await send('Page.enable'); await send('Runtime.enable');
await send('Page.navigate', { url: BASE + 'config.html' });
await sleep(4500);
const r = await send('Runtime.evaluate', { awaitPromise: true, returnByValue: true, expression: `(async () => {
  const blobs = [];
  const oc = URL.createObjectURL;
  URL.createObjectURL = function (b) { blobs.push(b); return oc.call(URL, b); };
  const btn = document.getElementById('dljson');
  if (!btn) return JSON.stringify({ 结果: '找不到 #dljson' });
  btn.click();
  await new Promise(r => setTimeout(r, 2500));
  URL.createObjectURL = oc;
  const out = { 按钮文字: btn.textContent.trim(), 生成Blob数: blobs.length };
  if (blobs.length) {
    out.大小 = blobs[0].size;
    const t = await blobs[0].text();
    out.前160字 = t.slice(0, 160);
    try { const j = JSON.parse(t); out.可解析JSON = true; out.顶层键 = Object.keys(j); } catch (e) { out.可解析JSON = false; }
  }
  return JSON.stringify(out, null, 1);
})()` });
console.log(r.result.value);
ws.close(); process.exit(0);

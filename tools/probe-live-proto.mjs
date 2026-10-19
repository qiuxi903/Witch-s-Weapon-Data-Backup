// 用浏览器确认实际协商的 HTTP 协议版本 + 统计响应头
const PORT = process.argv[2] || '9223';
const BASE = (process.argv[3] || 'https://witchweapon.hutaomu.cn/').replace(/\/$/, '') + '/';
const list = await (await fetch(`http://127.0.0.1:${PORT}/json/list`)).json();
const target = list.find(t => t.type === 'page');
const ws = new WebSocket(target.webSocketDebuggerUrl);
let id = 0; const pending = new Map();
const seen = [];
ws.addEventListener('message', ev => {
  const m = JSON.parse(ev.data);
  if (m.id && pending.has(m.id)) { const p = pending.get(m.id); pending.delete(m.id);
    m.error ? p.reject(new Error(JSON.stringify(m.error))) : p.resolve(m.result); return; }
  if (m.method === 'Network.responseReceived') {
    const r = m.params.response;
    seen.push({ url: r.url, proto: r.protocol, status: r.status, mime: r.mimeType,
                cache: r.headers['cache-control'] || r.headers['Cache-Control'] || '',
                expires: r.headers['expires'] || r.headers['Expires'] || '' });
  }
});
const send = (method, params = {}) => new Promise((resolve, reject) => {
  const myId = ++id; pending.set(myId, { resolve, reject });
  ws.send(JSON.stringify({ id: myId, method, params }));
  setTimeout(() => { if (pending.has(myId)) { pending.delete(myId); reject(new Error('timeout')); } }, 90000);
});
const sleep = ms => new Promise(r => setTimeout(r, ms));
await new Promise(r => ws.addEventListener('open', r));
await send('Network.enable'); await send('Page.enable'); await send('Runtime.enable');
await send('Page.navigate', { url: BASE + 'index.html' });
await sleep(6000);
const protos = {};
for (const s of seen) protos[s.proto] = (protos[s.proto] || 0) + 1;
console.log('=== 浏览器实际协商的协议 ===');
console.log('  ' + JSON.stringify(protos));
console.log('');
console.log('=== 各类资源的缓存头 ===');
const byExt = {};
for (const s of seen) {
  const e = (s.url.split('?')[0].split('.').pop() || '').toLowerCase().slice(0, 8);
  if (!byExt[e]) byExt[e] = { n: 0, cache: new Set(), expires: new Set(), proto: new Set() };
  byExt[e].n++; byExt[e].proto.add(s.proto);
  byExt[e].cache.add(s.cache || '(无)');
  byExt[e].expires.add(s.expires ? '有' : '(无)');
}
for (const [e, v] of Object.entries(byExt)) {
  console.log(`  ${e.padEnd(8)} ${String(v.n).padStart(3)} 个  ${[...v.proto].join('/')}  Cache-Control: ${[...v.cache].join(' , ')}  Expires: ${[...v.expires].join(',')}`);
}
ws.close(); process.exit(0);

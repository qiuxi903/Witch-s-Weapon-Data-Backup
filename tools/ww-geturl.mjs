// 重新走一遍流程，拿到 download 的最终重定向 URL（Location）
const r = await fetch('http://127.0.0.1:9222/json/list');
const list = await r.json();
const page = list.find(t => t.type === 'page' && t.url.includes('witchweapon.wiki'));
if (!page) { console.error('NO PAGE'); process.exit(1); }

const ws = new WebSocket(page.webSocketDebuggerUrl);
let id = 0;
const pending = new Map();
ws.addEventListener('message', ev => {
  const msg = JSON.parse(ev.data);
  if (msg.id && pending.has(msg.id)) {
    const { resolve, reject } = pending.get(msg.id);
    pending.delete(msg.id);
    if (msg.error) reject(new Error(JSON.stringify(msg.error)));
    else resolve(msg.result);
  }
});
function send(method, params = {}) {
  return new Promise((resolve, reject) => {
    const myId = ++id;
    pending.set(myId, { resolve, reject });
    ws.send(JSON.stringify({ id: myId, method, params }));
    setTimeout(() => { if (pending.has(myId)) { pending.delete(myId); reject(new Error('timeout ' + method)); } }, 180000);
  });
}
await new Promise(res => ws.addEventListener('open', res));
await send('Runtime.enable');

// 在页面里完整走一遍：catalog -> generate-download -> download(手动跟随重定向)
const expr = `(async () => {
  const API = 'https://api.witchweapon.wiki';
  const out = {};
  try {
    const gd = await fetch(API + '/api/v2/generate-download', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      credentials: 'omit', cache: 'no-store',
      body: JSON.stringify({ project: 'reunion', platform: 'android' })
    });
    out.genStatus = gd.status;
    const gj = await gd.json();
    out.genBody = gj;
    const dlUrl = gj.url || (gj.token ? (API + '/api/v2/download?token=' + encodeURIComponent(gj.token)) : null);
    out.dlUrl = dlUrl;
    if (dlUrl) {
      // 用 fetch 拿重定向目标（redirect: manual 拿不到跨域 Location，改用 HEAD 跟随）
      const h = await fetch(dlUrl, { method: 'GET', credentials: 'omit', cache: 'no-store', redirect: 'follow' });
      out.finalStatus = h.status;
      out.finalUrl = h.url;
      out.contentLength = h.headers.get('content-length');
      out.contentType = h.headers.get('content-type');
      try { h.body && h.body.cancel(); } catch(e){}
    }
  } catch (e) { out.error = String(e); }
  return JSON.stringify(out);
})()`;

const t = await send('Runtime.evaluate', { expression: expr, returnByValue: true, awaitPromise: true });
console.log(t.result.value);
ws.close();
process.exit(0);

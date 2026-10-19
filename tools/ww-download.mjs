// 通过 CDP 在已加载的怀旧服页面里触发下载流程，捕获真实下载 URL
const API = 'https://api.witchweapon.wiki';

const r = await fetch('http://127.0.0.1:9222/json/list');
const list = await r.json();
const page = list.find(t => t.type === 'page' && t.url.includes('witchweapon.wiki'));
if (!page) { console.error('NO PAGE'); process.exit(1); }
console.error('[target]', page.url);

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

// 在页面上下文里直接调用 API（带上页面的 Origin/Referer）
const expr = `(async () => {
  const API = '${API}';
  const out = { steps: [] };
  try {
    // 1) catalog
    const cat = await fetch(API + '/api/v2/catalog', { credentials: 'omit', cache: 'no-store' });
    out.catalog = await cat.json();
    out.steps.push('catalog ok');

    // 2) 找页面上的 Turnstile token
    const ts = document.querySelector('[name="cf-turnstile-response"]');
    out.turnstileValue = ts ? ts.value : null;
    out.hasTurnstileWidget = !!document.querySelector('.cf-turnstile, [data-sitekey]');

    // 3) 尝试 generate-download（带 token 如果有）
    const body = { project: 'reunion', platform: 'android' };
    if (out.turnstileValue) body.turnstileToken = out.turnstileValue;
    const gd = await fetch(API + '/api/v2/generate-download', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      credentials: 'omit', cache: 'no-store',
      body: JSON.stringify(body)
    });
    out.generateStatus = gd.status;
    out.generateBody = await gd.text();
    out.steps.push('generate-download ' + gd.status);
  } catch (e) {
    out.error = String(e);
  }
  return JSON.stringify(out);
})()`;

const t = await send('Runtime.evaluate', { expression: expr, returnByValue: true, awaitPromise: true });
console.log(t.result.value);
ws.close();
process.exit(0);

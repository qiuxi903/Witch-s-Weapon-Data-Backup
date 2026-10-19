// 点击下载按钮 -> 等 Turnstile -> 捕获 generate-download 请求与响应
const r = await fetch('http://127.0.0.1:9222/json/list');
const list = await r.json();
const page = list.find(t => t.type === 'page' && t.url.includes('witchweapon.wiki'));
if (!page) { console.error('NO PAGE'); process.exit(1); }
console.error('[target]', page.url);

const ws = new WebSocket(page.webSocketDebuggerUrl);
let id = 0;
const pending = new Map();
const events = [];
ws.addEventListener('message', ev => {
  const msg = JSON.parse(ev.data);
  if (msg.id && pending.has(msg.id)) {
    const { resolve, reject } = pending.get(msg.id);
    pending.delete(msg.id);
    if (msg.error) reject(new Error(JSON.stringify(msg.error)));
    else resolve(msg.result);
  } else if (msg.method) {
    events.push(msg);
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
await send('Network.enable');
await send('Page.enable');

// 1) 点击下载按钮
const clickExpr = `(() => {
  const btns = [...document.querySelectorAll('[data-download-project="reunion"]')];
  if (!btns.length) return 'NO_BUTTON';
  btns[0].click();
  return 'CLICKED ' + btns.length + ' buttons';
})()`;
const c = await send('Runtime.evaluate', { expression: clickExpr, returnByValue: true });
console.log('[click]', c.result.value);

// 2) 等 Turnstile 渲染
for (let i = 0; i < 20; i++) {
  await new Promise(r => setTimeout(r, 2000));
  const s = await send('Runtime.evaluate', {
    expression: `JSON.stringify({
      turnstile: !!document.querySelector('.cf-turnstile, [data-sitekey], iframe[src*="challenges.cloudflare"]'),
      token: (document.querySelector('[name="cf-turnstile-response"]')||{}).value || null,
      dialog: !!document.querySelector('dialog[open], .modal, [role="dialog"]'),
      bodyLen: document.body.innerHTML.length
    })`,
    returnByValue: true
  });
  const st = JSON.parse(s.result.value);
  console.log('[wait ' + i + ']', JSON.stringify(st));
  if (st.token) { console.log('*** TOKEN FOUND ***'); break; }
}

// 3) dump 网络事件里跟 download 相关的
const net = events.filter(e => e.method === 'Network.responseReceived' || e.method === 'Network.requestWillBeSent');
for (const e of net) {
  const u = e.params?.request?.url || e.params?.response?.url || '';
  if (u.includes('api.witchweapon') || u.includes('download')) {
    console.log('[net]', e.method, e.params.response?.status || '', u);
  }
}

// 4) dump 页面里所有 iframe
const f = await send('Runtime.evaluate', {
  expression: `JSON.stringify([...document.querySelectorAll('iframe')].map(x => x.src))`,
  returnByValue: true
});
console.log('[iframes]', f.result.value);

ws.close();
process.exit(0);

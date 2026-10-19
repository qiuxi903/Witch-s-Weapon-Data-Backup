// Minimal CDP driver over raw WebSocket (Node 24 has global WebSocket)
const [, , targetUrl, mode, expr] = process.argv;

async function getPageTarget() {
  const r = await fetch('http://127.0.0.1:9222/json/list');
  const list = await r.json();
  const pages = list.filter(t => t.type === 'page' && !t.url.startsWith('chrome-extension://'));
  if (targetUrl && targetUrl !== '-') {
    const hit = pages.find(p => p.url.includes(targetUrl));
    if (hit) return hit;
  }
  return pages[0];
}

const target = await getPageTarget();
if (!target) { console.error('NO PAGE TARGET'); process.exit(1); }
console.error('[target]', target.url);

const ws = new WebSocket(target.webSocketDebuggerUrl);
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
    setTimeout(() => {
      if (pending.has(myId)) { pending.delete(myId); reject(new Error('timeout ' + method)); }
    }, 120000);
  });
}

await new Promise(res => ws.addEventListener('open', res));
await send('Runtime.enable');
await send('Page.enable');

if (mode === 'nav') {
  await send('Page.navigate', { url: expr });
  await new Promise(r => setTimeout(r, 12000));
  const t = await send('Runtime.evaluate', { expression: 'document.title + " ||| " + location.href', returnByValue: true });
  console.log(t.result.value);
} else if (mode === 'eval') {
  const t = await send('Runtime.evaluate', { expression: expr, returnByValue: true, awaitPromise: true });
  console.log(typeof t.result.value === 'string' ? t.result.value : JSON.stringify(t.result.value, null, 2));
} else if (mode === 'html') {
  const t = await send('Runtime.evaluate', { expression: 'document.documentElement.outerHTML', returnByValue: true });
  console.log(t.result.value);
} else if (mode === 'cookies') {
  const t = await send('Network.getAllCookies');
  console.log(JSON.stringify(t.cookies.filter(c => c.domain.includes('apkpure')), null, 2));
}

ws.close();
process.exit(0);

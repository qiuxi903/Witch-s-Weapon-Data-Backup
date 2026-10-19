// Navigate to a URL and capture the final response headers + first bytes via CDP Network events
const [, , targetSub, url] = process.argv;

const r = await fetch('http://127.0.0.1:9222/json/list');
const list = await r.json();
const pages = list.filter(t => t.type === 'page' && !t.url.startsWith('chrome-extension://'));
const target = pages.find(p => p.url.includes(targetSub)) || pages[0];
console.error('[target]', target.url);

const ws = new WebSocket(target.webSocketDebuggerUrl);
let id = 0;
const pending = new Map();
const events = [];

ws.addEventListener('message', ev => {
  const msg = JSON.parse(ev.data);
  if (msg.id && pending.has(msg.id)) {
    const { resolve, reject } = pending.get(msg.id);
    pending.delete(msg.id);
    msg.error ? reject(new Error(JSON.stringify(msg.error))) : resolve(msg.result);
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
await send('Network.enable');
await send('Page.enable');
await send('Network.setExtraHTTPHeaders', { headers: { 'Referer': 'https://apkpure.com/' } });

// Start navigation but abort after headers arrive (we only want metadata, not 1.3GB)
await send('Page.navigate', { url });

const deadline = Date.now() + 45000;
let done = false;
while (Date.now() < deadline && !done) {
  await new Promise(r => setTimeout(r, 1500));
  for (const e of events) {
    if (e.method === 'Network.responseReceived') {
      const resp = e.params.response;
      if (/apkpure|pureapk|\.xapk|\.obb|\.apk/i.test(resp.url) && resp.status !== 302 && resp.status !== 301) {
        console.log(JSON.stringify({
          url: resp.url, status: resp.status, mimeType: resp.mimeType,
          headers: resp.headers, fromDiskCache: resp.fromDiskCache
        }, null, 2));
        if (resp.status === 200) { done = true; }
      }
    }
  }
}
if (!done) console.log('NO 200 CAPTURED; all responses:');
if (!done) {
  for (const e of events) {
    if (e.method === 'Network.responseReceived') console.log(' ', e.params.response.status, e.params.response.url.slice(0, 160));
  }
}

// Abort the download to avoid pulling 1.3GB
try { await send('Page.stopLoading'); } catch {}
ws.close();
process.exit(0);

// 点击 -> 捕获 download URL -> 立即用 curl 下载（token 5 分钟有效）
const fs = await import('node:fs');

const r = await fetch('http://127.0.0.1:9222/json/list');
const list = await r.json();
const page = list.find(t => t.type === 'page' && t.url.includes('witchweapon.wiki'));
if (!page) { console.error('NO PAGE'); process.exit(1); }

const ws = new WebSocket(page.webSocketDebuggerUrl);
let id = 0;
const pending = new Map();
let dlUrl = null;
let dlToken = null;
ws.addEventListener('message', ev => {
  const msg = JSON.parse(ev.data);
  if (msg.id && pending.has(msg.id)) {
    const { resolve, reject } = pending.get(msg.id);
    pending.delete(msg.id);
    if (msg.error) reject(new Error(JSON.stringify(msg.error)));
    else resolve(msg.result);
  } else if (msg.method === 'Network.requestWillBeSent') {
    const u = msg.params?.request?.url || '';
    if (u.includes('/api/v2/download?token=')) {
      dlUrl = u;
      const m = u.match(/token=([^&]+)/);
      if (m) dlToken = decodeURIComponent(m[1]);
    }
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

// 重新加载页面，保证状态干净
await send('Page.navigate', { url: 'https://www.witchweapon.wiki/' });
await new Promise(r => setTimeout(r, 10000));

// 点击下载按钮
const c = await send('Runtime.evaluate', {
  expression: `(() => { const b=[...document.querySelectorAll('[data-download-project="reunion"]')]; if(!b.length) return 'NO_BUTTON'; b[0].click(); return 'CLICKED'; })()`,
  returnByValue: true
});
console.error('[click]', c.result.value);

// 等 download 请求出现
for (let i = 0; i < 40; i++) {
  await new Promise(r => setTimeout(r, 1500));
  if (dlUrl) break;
}

if (dlUrl) {
  fs.writeFileSync('G:\\project\\其他\\game\\tools\\ww_dl_url.txt', dlUrl, 'utf8');
  console.log('DL_URL=' + dlUrl);
  console.log('TOKEN_LEN=' + (dlToken ? dlToken.length : 0));
} else {
  console.log('NO_DL_URL');
}
ws.close();
process.exit(0);

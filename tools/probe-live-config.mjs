// 线上站点：配置表页 5 个区服切换 + CSV/JSON 导出 + 整包 ZIP 下载
//   node tools/probe-live-config.mjs [CDP端口] [站点根URL]
const PORT = process.argv[2] || '9223';
const BASE = (process.argv[3] || 'https://witchweapon.hutaomu.cn/').replace(/\/$/, '') + '/';

const list = await (await fetch(`http://127.0.0.1:${PORT}/json/list`)).json();
const target = list.find(t => t.type === 'page');
if (!target) { console.error('没有可用的页面目标'); process.exit(2); }
const ws = new WebSocket(target.webSocketDebuggerUrl);
let id = 0; const pending = new Map();
ws.addEventListener('message', ev => {
  const m = JSON.parse(ev.data);
  if (m.id && pending.has(m.id)) {
    const { resolve, reject } = pending.get(m.id); pending.delete(m.id);
    m.error ? reject(new Error(JSON.stringify(m.error))) : resolve(m.result);
  }
});
function send(method, params = {}) {
  return new Promise((resolve, reject) => {
    const myId = ++id; pending.set(myId, { resolve, reject });
    ws.send(JSON.stringify({ id: myId, method, params }));
    setTimeout(() => { if (pending.has(myId)) { pending.delete(myId); reject(new Error('timeout ' + method)); } }, 120000);
  });
}
const sleep = ms => new Promise(r => setTimeout(r, ms));
await new Promise(r => ws.addEventListener('open', r));
await send('Page.enable'); await send('Runtime.enable');

async function ev(expr, awaitPromise = true) {
  const r = await send('Runtime.evaluate', { expression: expr, awaitPromise, returnByValue: true });
  if (r.exceptionDetails) return 'JS异常: ' + JSON.stringify(r.exceptionDetails.exception?.description || r.exceptionDetails.text);
  return r.result.value;
}

await send('Page.navigate', { url: BASE + 'config.html' });
await sleep(4000);

console.log('=== 配置表页：区服标签 ===');
console.log(await ev(`(() => {
  const tabs = [...document.querySelectorAll('button, a, [role=tab], .tab, .ver')]
    .map(e => e.textContent.trim()).filter(t => t && t.length < 30);
  return JSON.stringify({ 候选标签: tabs.slice(0, 20) }, null, 1);
})()`));

console.log('');
console.log('=== 逐个点开区服，看表格是否渲染 ===');
for (const name of ['怀旧服', '国服', '日服', '港澳台', '韩服']) {
  const r = await ev(`(async () => {
    const el = [...document.querySelectorAll('button, a, [role=tab], .tab, .ver')]
      .find(e => e.textContent.trim().startsWith(${JSON.stringify(name)}));
    if (!el) return JSON.stringify({ 区服: ${JSON.stringify(name)}, 结果: '找不到标签' });
    el.click();
    await new Promise(r => setTimeout(r, 6000));
    const tables = document.querySelectorAll('table');
    const rows = document.querySelectorAll('table tr');
    const cells = document.querySelectorAll('table td');
    return JSON.stringify({
      区服: ${JSON.stringify(name)},
      表格数: tables.length,
      行数: rows.length,
      单元格数: cells.length,
      首行样例: [...document.querySelectorAll('table tr')].slice(0,2).map(tr =>
        [...tr.children].slice(0,4).map(td => td.textContent.trim().slice(0,14))),
    });
  })()`);
  console.log('  ' + r);
}

console.log('');
console.log('=== CSV / JSON 导出（浏览器现场生成）===');
console.log(await ev(`(async () => {
  const out = {};
  // 找导出按钮
  const btns = [...document.querySelectorAll('button, a')].filter(b => b.textContent.includes('⤓'));
  out.按钮 = btns.map(b => b.textContent.trim().slice(0, 40));
  // 直接调用页面里的生成函数不可靠，改成拦截 Blob 下载
  const blobs = [];
  const origCreate = URL.createObjectURL;
  URL.createObjectURL = function (b) { blobs.push(b); return origCreate.call(URL, b); };
  const csvBtn = btns.find(b => b.textContent.includes('CSV'));
  if (csvBtn) { csvBtn.click(); await new Promise(r => setTimeout(r, 2500)); }
  const jsonBtn = btns.find(b => b.textContent.includes('JSON'));
  if (jsonBtn) { jsonBtn.click(); await new Promise(r => setTimeout(r, 2500)); }
  URL.createObjectURL = origCreate;
  out.生成的Blob数 = blobs.length;
  out.Blob类型 = blobs.map(b => b.type + ' ' + b.size + 'B');
  if (blobs.length) {
    const t = await blobs[0].text();
    out.首个内容前120字 = t.slice(0, 120).replace(/\\r?\\n/g, ' | ');
  }
  return JSON.stringify(out, null, 1);
})()`));

console.log('');
console.log('=== 整包 ZIP 下载 ===');
console.log(await ev(`(async () => {
  const a = [...document.querySelectorAll('a')].find(x => (x.getAttribute('href')||'').includes('.zip'));
  if (!a) return JSON.stringify({ 结果: '页面上没有 .zip 链接' });
  const href = a.getAttribute('href');
  const r = await fetch(href);
  const buf = await r.arrayBuffer();
  const b = new Uint8Array(buf);
  return JSON.stringify({
    链接: href,
    HTTP状态: r.status,
    大小: buf.byteLength,
    魔数: [...b.slice(0, 4)].map(x => x.toString(16).padStart(2,'0')).join(' '),
    是合法ZIP: b[0] === 0x50 && b[1] === 0x4b,
  }, null, 1);
})()`));

ws.close();
process.exit(0);

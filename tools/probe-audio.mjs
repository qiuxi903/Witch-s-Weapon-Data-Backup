// 对比探测单个音频页：加载 → 等待 → 统计 WebMediaPlayer 相关报错与媒体元素状态
// 用法：node tools/probe-audio.mjs <url> <标签>
const [, , url, label] = process.argv;
const PORT = process.env.CDP_PORT || '9223';

const list = await (await fetch(`http://127.0.0.1:${PORT}/json/list`)).json();
const target = list.find(t => t.type === 'page');
const ws = new WebSocket(target.webSocketDebuggerUrl);
let id = 0;
const pending = new Map();
let errs = [];

ws.addEventListener('message', ev => {
  const m = JSON.parse(ev.data);
  if (m.id && pending.has(m.id)) {
    const { resolve, reject } = pending.get(m.id);
    pending.delete(m.id);
    m.error ? reject(new Error(JSON.stringify(m.error))) : resolve(m.result);
    return;
  }
  if (m.method === 'Log.entryAdded' && m.params.entry.level === 'error')
    errs.push(m.params.entry.text);
  if (m.method === 'Runtime.exceptionThrown') {
    const d = m.params.exceptionDetails;
    errs.push('异常: ' + (d.exception?.description || d.text));
  }
});

function send(method, params = {}) {
  return new Promise((resolve, reject) => {
    const myId = ++id;
    pending.set(myId, { resolve, reject });
    ws.send(JSON.stringify({ id: myId, method, params }));
    setTimeout(() => { if (pending.has(myId)) { pending.delete(myId); reject(new Error('timeout ' + method)); } }, 120000);
  });
}
const sleep = ms => new Promise(r => setTimeout(r, ms));

await new Promise(r => ws.addEventListener('open', r));
await send('Network.enable');
await send('Page.enable');
await send('Runtime.enable');
await send('Log.enable');

// FORCE_NO_OPUS=1 时模拟 Safari：让 canPlayType 对 Opus 返回空，检验 mp3 回退
if (process.env.FORCE_NO_OPUS === '1') {
  await send('Page.addScriptToEvaluateOnNewDocument', { source: `
    (function () {
      var orig = HTMLMediaElement.prototype.canPlayType;
      HTMLMediaElement.prototype.canPlayType = function (t) {
        if (/opus/i.test(t)) return '';
        return orig.call(this, t);
      };
    })();
  ` });
  console.log('  [已注入 Safari 模拟：Opus 不支持]');
}

// Log.enable 会重放该标签页已缓冲的历史日志，先清空再开始，避免上一轮结果被重复计入
await send('Page.navigate', { url: 'about:blank' });
await sleep(1200);
errs = [];

// 先关掉所有折叠，模拟"用户刚开始只看到第一组"
await send('Page.navigate', { url });
await sleep(3000);

const STATE = `(() => {
  const aud = [...document.querySelectorAll('audio')];
  const withSrc = aud.filter(a => a.getAttribute('src'));
  const withSource = aud.filter(a => a.querySelector('source[src]'));
  return JSON.stringify({
    audio: aud.length,
    withSrc: withSrc.length,
    withSource: withSource.length,
    opened: [...document.querySelectorAll('details')].filter(d => d.open).length,
    errCount: window.__errCount || 0,
    sample: withSrc.slice(0, 2).map(a => a.getAttribute('src').split('/').pop())
  });
})()`;

const r0 = JSON.parse((await send('Runtime.evaluate', { expression: STATE, returnByValue: true })).result.value);
// 再点开第一组（模拟用户展开）
await send('Runtime.evaluate', { expression:
  `(() => { const f = document.querySelector('details.fold'); if (f) { f.open = true;
     f.dispatchEvent(new Event('toggle')); } return 1; })()` });
await sleep(5000);

const r1 = JSON.parse((await send('Runtime.evaluate', { expression: STATE, returnByValue: true })).result.value);

const wmp = errs.filter(e => /WebMediaPlayer|too many/i.test(e));

// ALL_FOLDS=1 时再模拟"一次性展开全部分组"的压力情形
let wmpAll = null;
if (process.env.ALL_FOLDS === '1') {
  const before = errs.length;
  await send('Runtime.evaluate', { expression:
    `[...document.querySelectorAll('details.fold')].forEach(f => { f.open = true;
       f.dispatchEvent(new Event('toggle')); })` });
  await sleep(6000);
  wmpAll = errs.filter(e => /WebMediaPlayer|too many/i.test(e)).length;
}

console.log(`=== ${label} ===`);
console.log(`  URL: ${url}`);
console.log(`  加载完成:  audio ${r0.audio} 个, 带 src ${r0.withSrc}, 折叠打开 ${r0.opened}`);
console.log(`  展开第一组: 带 src ${r1.withSrc}, 带 source ${r1.withSource}`);
console.log(`  实际选中格式样例: ${(r1.sample || []).join(' , ')}`);
console.log(`  WebMediaPlayer 报错: ${wmp.length} 条`);
if (wmp.length) console.log(`     例: ${wmp[0].slice(0, 110)}`);
if (wmpAll !== null) console.log(`  再展开全部分组后 WebMediaPlayer 报错: ${wmpAll} 条`);
const other = errs.filter(e => !/WebMediaPlayer|too many/i.test(e));
console.log(`  其它 JS 报错: ${other.length} 条`);
if (other.length) console.log(`     例: ${other[0].slice(0, 110)}`);
ws.close();
process.exit(0);

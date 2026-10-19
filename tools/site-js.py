# 网站 JS v5 —— 暗色默认 + 侧栏收起 + 动效 + 移动端
import io, os, sys

sys.stdout.reconfigure(encoding='utf-8', errors='replace')
sys.path.insert(0, r'G:\project\其他\game\tools')
from site_lib import SITE          # 部署模式下自动指向 部署/
os.makedirs(os.path.join(SITE, 'js'), exist_ok=True)

JS = r'''/* ============================================================
   《魔女兵器》收藏档案 — 交互脚本 v5
   主题 / 侧栏收起 / 移动抽屉 / 懒加载 / 灯箱 / 动效
   ============================================================ */
(function () {
  'use strict';

  var TKEY = 'ww-theme';
  var CKEY = 'ww-mini';

  /* ---------- 主题（默认暗色） ---------- */
  function initTheme() {
    var btns = [
      { b: document.getElementById('themeBtn'),
        i: document.getElementById('themeIc'),
        t: document.getElementById('themeTx') },
      { b: document.getElementById('topTheme'),
        i: document.getElementById('topThemeIc') }
    ].filter(function (x) { return x.b; });
    if (!btns.length) return;

    function isLight() {
      return document.documentElement.getAttribute('data-theme') === 'light';
    }
    function sync() {
      var l = isLight();
      btns.forEach(function (x) {
        if (x.i) x.i.textContent = l ? '\u25D0' : '\u25D1';
        if (x.t) x.t.textContent = l ? '暗色模式' : '亮色模式';
        x.b.setAttribute('aria-pressed', l ? 'true' : 'false');
        x.b.setAttribute('aria-label', l ? '切换到暗色模式' : '切换到亮色模式');
      });
    }
    btns.forEach(function (x) {
      x.b.addEventListener('click', function () {
        var next = isLight() ? 'dark' : 'light';
        if (next === 'light') document.documentElement.setAttribute('data-theme', 'light');
        else document.documentElement.removeAttribute('data-theme');
        try { localStorage.setItem(TKEY, next); } catch (e) {}
        sync();
      });
    });
    sync();
  }

  /* ---------- 侧栏收起（桌面） ---------- */
  function initCollapse() {
    var btn = document.getElementById('collapseBtn');
    var ar = document.getElementById('collapseAr');
    var body = document.body;
    var root = document.documentElement;

    // 内联脚本已按 localStorage 设了 data-mini（避免闪烁），这里接管
    function isMini() { return root.hasAttribute('data-mini'); }
    function setMini(on) {
      if (on) { root.setAttribute('data-mini', '1'); body.classList.add('mini'); }
      else { root.removeAttribute('data-mini'); body.classList.remove('mini'); }
      try { localStorage.setItem(CKEY, on ? '1' : '0'); } catch (e) {}
      sync();
    }
    function sync() {
      if (!btn) return;
      var mini = isMini();
      btn.setAttribute('aria-expanded', mini ? 'false' : 'true');
      btn.setAttribute('aria-label', mini ? '展开侧边栏' : '收起侧边栏');
      btn.title = mini ? '展开侧边栏' : '收起侧边栏';
      if (ar) ar.textContent = mini ? '\u00BB' : '\u00AB';
    }
    if (btn) btn.addEventListener('click', function () { setMini(!isMini()); });
    sync();
  }

  /* ---------- 移动端抽屉 ---------- */
  function initMenu() {
    var btn = document.getElementById('menuBtn');
    var side = document.getElementById('side');
    if (!btn || !side) return;
    function close() {
      side.classList.remove('open');
      btn.setAttribute('aria-expanded', 'false');
    }
    btn.addEventListener('click', function (e) {
      e.stopPropagation();
      var open = side.classList.toggle('open');
      btn.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
    document.addEventListener('click', function (e) {
      if (side.classList.contains('open') &&
          !side.contains(e.target) && e.target !== btn) close();
    });
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') close();
    });
    Array.prototype.forEach.call(side.querySelectorAll('a'), function (a) {
      a.addEventListener('click', close);
    });
    // 视口变宽时自动收起抽屉
    if (window.matchMedia) {
      var mq = window.matchMedia('(min-width: 881px)');
      var on = function () { if (mq.matches) close(); };
      if (mq.addEventListener) mq.addEventListener('change', on);
      else if (mq.addListener) mq.addListener(on);
    }
  }

  /* ---------- 分类懒加载 ---------- */
  function initLazyFolds() {
    var folds = Array.prototype.slice.call(document.querySelectorAll('details.fold'));
    if (!folds.length) return;

    function load(fold) {
      if (fold.getAttribute('data-loaded')) return;
      fold.setAttribute('data-loaded', '1');
      ['img', 'audio', 'video'].forEach(function (tag) {
        var els = fold.querySelectorAll(tag + '[data-src]');
        Array.prototype.forEach.call(els, function (el) {
          if (tag === 'img') {
            el.addEventListener('load', function () {
              el.classList.add('ok');
              var it = el.closest ? el.closest('.gal-item') : null;
              if (it) it.classList.add('loaded');
            });
            el.addEventListener('error', function () {
              var it = el.closest ? el.closest('.gal-item') : null;
              if (it) it.classList.add('loaded');
            });
          }
          var ds = el.getAttribute('data-src');
          var da = el.getAttribute('data-alt');
          // 音频双格式：不支持 Opus 的浏览器（Safari）退回 mp3。
          // 必须用单一 src + preload="none"，<source> 子元素会让浏览器
          // 在资源选择阶段就创建播放器，一页上千个会撞上 Chrome 的上限。
          if (da && el.canPlayType &&
              !el.canPlayType('audio/ogg; codecs="opus"')) ds = da;
          el.src = ds;
          el.removeAttribute('data-src');
          el.removeAttribute('data-alt');
        });
      });
    }

    folds.forEach(function (f) {
      if (f.open) load(f);
      f.addEventListener('toggle', function () { if (f.open) load(f); });
    });

    if (location.hash) {
      var t = document.querySelector(location.hash);
      if (t && t.tagName === 'DETAILS') {
        t.open = true; load(t);
        setTimeout(function () {
          try { t.scrollIntoView({ behavior: 'smooth', block: 'start' }); } catch (e) {}
        }, 60);
      }
    }
  }

  /* ---------- 关键词过滤 ---------- */
  function bindFilter(inputId, itemSel, statId, attr) {
    var inp = document.getElementById(inputId);
    if (!inp) return;
    var items = Array.prototype.slice.call(document.querySelectorAll(itemSel));
    var timer = null;
    function run() {
      var kws = inp.value.trim().toLowerCase().split(/\s+/).filter(Boolean);
      var n = 0;
      items.forEach(function (el) {
        var t = (attr ? (el.getAttribute(attr) || '') : el.textContent).toLowerCase();
        var ok = kws.every(function (k) { return t.indexOf(k) !== -1; });
        el.classList.toggle('hide', !ok);
        if (ok) n++;
      });
      var st = document.getElementById(statId);
      if (st) {
        st.textContent = kws.length
          ? ('匹配 ' + n.toLocaleString() + ' / ' + items.length.toLocaleString())
          : (items.length.toLocaleString() + ' 项');
      }
      // 搜索时自动展开命中的折叠块
      if (kws.length) {
        Array.prototype.forEach.call(
          document.querySelectorAll('details.fold'),
          function (f) {
            if (f.querySelector('.hide') === null &&
                f.querySelector(items.length ? items[0].className.split(' ')[0] : 'x')) {
              f.open = true;
            }
          });
      }
    }
    inp.addEventListener('input', function () {
      clearTimeout(timer); timer = setTimeout(run, 140);
    });
    run();
  }

  /* ---------- 表格过滤 ---------- */
  function bindTable(inputId, tableId, statId) {
    var inp = document.getElementById(inputId);
    if (!inp) return;
    var tb = document.querySelector('#' + tableId + ' tbody');
    if (!tb) return;
    var rows = Array.prototype.slice.call(tb.rows);
    var timer = null;
    function run() {
      var kws = inp.value.trim().toLowerCase().split(/\s+/).filter(Boolean);
      var n = 0;
      rows.forEach(function (r) {
        var t = r.textContent.toLowerCase();
        var ok = kws.every(function (k) { return t.indexOf(k) !== -1; });
        r.style.display = ok ? '' : 'none';
        if (ok) n++;
      });
      var st = document.getElementById(statId);
      if (st) {
        st.textContent = kws.length
          ? ('匹配 ' + n.toLocaleString() + ' / ' + rows.length.toLocaleString() + ' 行')
          : (rows.length.toLocaleString() + ' 行');
      }
    }
    inp.addEventListener('input', function () {
      clearTimeout(timer); timer = setTimeout(run, 140);
    });
    run();
  }

  /* ---------- 灯箱 ---------- */
  var LB = null, LIST = [], IDX = 0;

  function build() {
    if (LB) return LB;
    LB = document.createElement('div');
    LB.id = 'lb';
    LB.setAttribute('role', 'dialog');
    LB.setAttribute('aria-modal', 'true');
    LB.setAttribute('aria-label', '图片查看器');
    LB.innerHTML =
      '<button class="x" aria-label="关闭">\u00d7</button>' +
      '<button class="nav-btn prev" aria-label="上一张">\u2039</button>' +
      '<button class="nav-btn next" aria-label="下一张">\u203a</button>' +
      '<img alt="">' +
      '<div class="cap"></div>';
    document.body.appendChild(LB);
    LB.querySelector('.x').onclick = close;
    LB.querySelector('.prev').onclick = function (e) { e.stopPropagation(); step(-1); };
    LB.querySelector('.next').onclick = function (e) { e.stopPropagation(); step(1); };
    LB.onclick = function (e) { if (e.target === LB) close(); };
    // 触屏滑动翻页
    var sx = 0, sy = 0;
    LB.addEventListener('touchstart', function (e) {
      if (e.touches.length === 1) { sx = e.touches[0].clientX; sy = e.touches[0].clientY; }
    }, { passive: true });
    LB.addEventListener('touchend', function (e) {
      if (!e.changedTouches.length) return;
      var dx = e.changedTouches[0].clientX - sx;
      var dy = e.changedTouches[0].clientY - sy;
      if (Math.abs(dx) > 50 && Math.abs(dx) > Math.abs(dy)) step(dx < 0 ? 1 : -1);
      else if (dy > 80 && Math.abs(dy) > Math.abs(dx)) close();
    }, { passive: true });
    return LB;
  }

  function show() {
    var im = LIST[IDX];
    if (!im) return;
    var big = LB.querySelector('img');
    var fig = im.closest ? im.closest('figure') : null;
    big.src = (fig && fig.getAttribute('data-full')) ||
              im.getAttribute('data-src') || im.src;
    big.alt = im.alt || '';
    LB.querySelector('.cap').textContent =
      (im.getAttribute('data-cap') || im.alt || '') +
      '   ' + (IDX + 1) + ' / ' + LIST.length;
    var multi = LIST.length > 1;
    LB.querySelector('.prev').style.display = multi ? '' : 'none';
    LB.querySelector('.next').style.display = multi ? '' : 'none';
  }

  function open(list, i) {
    build();
    LIST = list; IDX = i;
    show();
    LB.classList.add('on');
    document.body.style.overflow = 'hidden';
    LB.querySelector('.x').focus();
  }

  function close() {
    if (!LB) return;
    LB.classList.remove('on');
    document.body.style.overflow = '';
  }

  function step(d) {
    if (!LIST.length) return;
    IDX = (IDX + d + LIST.length) % LIST.length;
    show();
  }

  function bindKeys() {
    if (bindKeys.done) return;
    bindKeys.done = true;
    document.addEventListener('keydown', function (e) {
      if (!LB || !LB.classList.contains('on')) return;
      if (e.key === 'Escape') close();
      else if (e.key === 'ArrowLeft') step(-1);
      else if (e.key === 'ArrowRight') step(1);
    });
  }

  function initGallery() {
    var items = Array.prototype.slice.call(document.querySelectorAll('.gal-item'));
    if (!items.length) return;
    items.forEach(function (el, i) {
      el.setAttribute('tabindex', '0');
      el.setAttribute('role', 'button');
      var img = el.querySelector('img');
      if (img) el.setAttribute('data-cap', img.alt || '');
      function act() { open(items, i); }
      el.addEventListener('click', act);
      el.addEventListener('keydown', function (e) {
        if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); act(); }
      });
    });
    bindKeys();
  }

  function initPosters() {
    var cards = Array.prototype.slice.call(document.querySelectorAll('.pcard'));
    if (!cards.length) return;
    var arts = [];
    cards.forEach(function (c) {
      var img = c.querySelector('.art');
      if (img) {
        img.setAttribute('data-cap', img.alt || '');
        arts.push(img);
      }
    });
    cards.forEach(function (c, i) {
      c.setAttribute('tabindex', '0');
      c.setAttribute('role', 'button');
      function act() { open(arts, i); }
      c.addEventListener('click', function (e) {
        if (e.target.closest('a')) return;
        act();
      });
      c.addEventListener('keydown', function (e) {
        if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); act(); }
      });
    });
    bindKeys();
  }

  /* ---------- 滚动显现（带兜底） ---------- */
  function initReveal() {
    var els = Array.prototype.slice.call(document.querySelectorAll('.rv'));
    if (!els.length) return;
    function show(el) { el.classList.add('in'); }
    setTimeout(function () { els.forEach(show); }, 1200);
    if (!('IntersectionObserver' in window)) { els.forEach(show); return; }
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (en) {
        if (en.isIntersecting) { show(en.target); io.unobserve(en.target); }
      });
    }, { rootMargin: '200px 0px 0px 0px', threshold: 0 });
    els.forEach(function (e) {
      var r = e.getBoundingClientRect();
      if (r.top < (window.innerHeight || 800) + 200) show(e);
      else io.observe(e);
    });
  }

  /* ---------- 数字滚动 ---------- */
  function initCounters() {
    var vs = Array.prototype.slice.call(document.querySelectorAll('.kpi .v'));
    if (!vs.length) return;
    vs.forEach(function (el) {
      var raw = el.textContent.trim();
      el.setAttribute('data-final', raw);
      var m = raw.match(/^([0-9][0-9,]*\.?[0-9]*)/);
      if (!m) return;
      var numStr = m[1];
      var target = parseFloat(numStr.replace(/,/g, ''));
      if (!isFinite(target) || target <= 0) return;
      var suffix = raw.slice(numStr.length);
      var dec = (numStr.split('.')[1] || '').length;
      var raf = window.requestAnimationFrame;
      if (typeof raf !== 'function') return;
      var started = false;
      function run() {
        if (started) return;
        started = true;
        var t0 = null, DUR = 900, done = false;
        function finish() { if (!done) { done = true; el.textContent = raw; } }
        setTimeout(finish, 1400);
        function frame(ts) {
          if (done) return;
          if (t0 === null) t0 = ts;
          var p = (ts - t0) / DUR;
          if (!isFinite(p) || p >= 1) { finish(); return; }
          var e = 1 - Math.pow(1 - p, 3);
          var cur = target * e;
          try {
            el.textContent = (dec ? cur.toFixed(dec)
                                  : Math.round(cur).toLocaleString()) + suffix;
          } catch (err) { finish(); return; }
          raf(frame);
        }
        raf(frame);
      }
      if (!('IntersectionObserver' in window)) { run(); return; }
      var io = new IntersectionObserver(function (entries) {
        entries.forEach(function (en) {
          if (en.isIntersecting) { run(); io.unobserve(en.target); }
        });
      }, { threshold: 0 });
      var r = el.getBoundingClientRect();
      if (r.top < (window.innerHeight || 800)) run();
      else io.observe(el);
    });
  }

  /* ---------- 返回顶部 ---------- */
  function initTop() {
    var b = document.getElementById('top');
    if (!b) return;
    var ticking = false;
    function upd() {
      var y = window.pageYOffset || document.documentElement.scrollTop || 0;
      b.classList.toggle('show', y > 500);
      ticking = false;
    }
    window.addEventListener('scroll', function () {
      if (!ticking) { ticking = true; requestAnimationFrame(upd); }
    }, { passive: true });
    b.addEventListener('click', function () {
      try { window.scrollTo({ top: 0, behavior: 'smooth' }); }
      catch (e) { window.scrollTo(0, 0); }
    });
    upd();
  }

  /* ---------- 图片淡入 ---------- */
  function initImgFade() {
    var imgs = Array.prototype.slice.call(
      document.querySelectorAll('.gal-item img:not([data-src]),' +
                               '.pcard .art,.card .thumb img'));
    imgs.forEach(function (im) {
      if (im.complete && im.naturalWidth > 0) {
        im.classList.add('ok');
        var it = im.closest ? im.closest('.gal-item') : null;
        if (it) it.classList.add('loaded');
        return;
      }
      im.setAttribute('data-fade', '1');
      im.addEventListener('load', function () {
        im.classList.add('ok');
        var it = im.closest ? im.closest('.gal-item') : null;
        if (it) it.classList.add('loaded');
      });
      im.addEventListener('error', function () {
        im.classList.add('ok');
        im.style.opacity = '.2';
        var it = im.closest ? im.closest('.gal-item') : null;
        if (it) it.classList.add('loaded');
      });
    });
  }

  function initFallback() {
    document.addEventListener('error', function (e) {
      var t = e.target;
      if (t && t.tagName === 'IMG' && !t.dataset.failed) {
        t.dataset.failed = '1';
        t.style.opacity = '.2';
      }
    }, true);
  }

  function boot() {
    initTheme();
    initCollapse();
    initMenu();
    initFallback();
    initLazyFolds();
    initImgFade();
    initGallery();
    initPosters();
    initReveal();
    initCounters();
    initTop();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', boot);
  } else {
    boot();
  }

  window.bindFilter = bindFilter;
  window.bindTable = bindTable;
})();
'''

p = os.path.join(SITE, 'js', 'app.js')
io.open(p, 'w', encoding='utf-8').write(JS)
print('JS v5 已写: %.1f KB' % (os.path.getsize(p) / 1024))

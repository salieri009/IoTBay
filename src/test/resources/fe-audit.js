/*
 * Frontend audit helpers injected into the page by the FE Selenium tests.
 * Defines window.__themeAudit() and window.__a11yAudit(selectors, maxSamples).
 * Uses the standard WCAG 2.x sRGB relative-luminance + contrast-ratio formulas.
 */
(function () {
  var A = {
    parse: function (c) {
      if (!c) return null;
      var m = c.match(/rgba?\(([^)]+)\)/);
      if (!m) return null;
      var p = m[1].split(',').map(function (x) { return parseFloat(x.trim()); });
      return [p[0], p[1], p[2], p.length > 3 ? p[3] : 1];
    },
    lum: function (rgb) {
      var a = rgb.slice(0, 3).map(function (v) {
        v = v / 255;
        return v <= 0.03928 ? v / 12.92 : Math.pow((v + 0.055) / 1.055, 2.4);
      });
      return 0.2126 * a[0] + 0.7152 * a[1] + 0.0722 * a[2];
    },
    contrast: function (fg, bg) {
      var l1 = this.lum(fg), l2 = this.lum(bg);
      var hi = Math.max(l1, l2), lo = Math.min(l1, l2);
      return (hi + 0.05) / (lo + 0.05);
    },
    // Resolve the effective opaque background by walking ancestors until an
    // (almost) opaque background-color is found; fall back to the body bg.
    effBg: function (el) {
      var node = el;
      while (node && node.nodeType === 1) {
        var c = this.parse(getComputedStyle(node).backgroundColor);
        if (c && c[3] >= 0.95) return c;
        node = node.parentElement;
      }
      return this.parse(getComputedStyle(document.body).backgroundColor) || [15, 23, 42, 1];
    },
    visible: function (el) {
      var r = el.getBoundingClientRect();
      if (r.width < 2 || r.height < 2) return false;
      var s = getComputedStyle(el);
      if (s.visibility === 'hidden' || s.display === 'none' || parseFloat(s.opacity) < 0.1) return false;
      return true;
    },
    // True only when the element has its OWN (direct) non-trivial text node.
    hasOwnText: function (el) {
      for (var i = 0; i < el.childNodes.length; i++) {
        var n = el.childNodes[i];
        if (n.nodeType === 3 && n.textContent.trim().length > 1) return true;
      }
      return false;
    },
    sel: function (el) {
      var s = el.tagName.toLowerCase();
      if (el.id) return s + '#' + el.id;
      if (el.className && typeof el.className === 'string') {
        var cls = el.className.trim().split(/\s+/).slice(0, 2).join('.');
        if (cls) s += '.' + cls;
      }
      return s;
    }
  };

  window.__themeAudit = function () {
    var out = {
      theme: document.documentElement.getAttribute('data-theme'),
      bodyBg: getComputedStyle(document.body).backgroundColor,
      leaks: []
    };
    var els = document.querySelectorAll('body, main, header, footer, section, aside, .card, .admin-sidebar, [class*="sidebar"], [class*="bg-white"]');
    for (var i = 0; i < els.length; i++) {
      var el = els[i];
      if (!A.visible(el)) continue;
      var r = el.getBoundingClientRect();
      if (r.width * r.height < 4000) continue; // ignore tiny surfaces
      var bg = A.parse(getComputedStyle(el).backgroundColor);
      if (!bg || bg[3] < 0.5) continue;        // transparent: not a leak source
      if (A.lum(bg) > 0.6) {
        out.leaks.push({
          sel: A.sel(el), bg: getComputedStyle(el).backgroundColor,
          lum: +A.lum(bg).toFixed(3), w: Math.round(r.width), h: Math.round(r.height)
        });
      }
    }
    return out;
  };

  window.__a11yAudit = function (selectors, maxSamples) {
    maxSamples = maxSamples || 400;
    var fails = [], checked = 0;
    var els = document.querySelectorAll(selectors);
    for (var i = 0; i < els.length && checked < maxSamples; i++) {
      var el = els[i];
      if (!A.visible(el) || !A.hasOwnText(el)) continue;
      checked++;
      var s = getComputedStyle(el);
      var fg = A.parse(s.color);
      if (!fg || fg[3] < 0.5) continue;
      var bg = A.effBg(el);
      var ratio = A.contrast(fg, bg);
      var size = parseFloat(s.fontSize);
      var bold = (parseInt(s.fontWeight, 10) || 400) >= 700;
      var large = size >= 24 || (bold && size >= 18.66);
      var req = large ? 3.0 : 4.5;
      if (ratio + 0.05 < req) { // small tolerance for rounding
        fails.push({
          sel: A.sel(el), text: el.textContent.trim().slice(0, 40),
          color: s.color,
          bg: 'rgb(' + Math.round(bg[0]) + ',' + Math.round(bg[1]) + ',' + Math.round(bg[2]) + ')',
          ratio: +ratio.toFixed(2), req: req, size: Math.round(size)
        });
      }
    }
    return { checked: checked, fails: fails };
  };
})();

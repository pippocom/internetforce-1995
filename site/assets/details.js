/* Internetforce 1995–1996 — generic document viewer logic (site/details.html)
 *
 * Renders repository Markdown client-side (via the vendored marked renderer)
 * and shows textual configuration files as plain monospaced text.
 * No framework, no CDN.
 *
 * Pure helpers are exported for testing (Node) via IFDetails.
 */
(function (root, factory) {
  var api = factory(root);
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
  if (root) root.IFDetails = api;
})(typeof globalThis !== 'undefined' ? globalThis : this, function (root) {
  'use strict';

  var ALLOWED_ROOTS = ['docs/', 'systems/', 'artifacts/'];
  var FORBIDDEN = ['_ref_INTF/'];
  var MD_RE = /\.(md|markdown)$/i;
  var SCHEME_RE = /^[a-zA-Z][a-zA-Z0-9+.-]*:/;

  /* Explicit allowlist of textual public repository content that may be shown
     as plain text. Deliberately conservative: binaries/images/PDFs are never
     rendered as text and stay direct links. */
  var TEXT_EXT = {
    cfg: 1, conf: 1, txt: 1, cf: 1, sh: 1, pl: 1, ini: 1, list: 1,
    boot: 1, save: 1, route: 1, local: 1, inet1: 1, inet2: 1, serial: 1,
    cdrom: 1, linux: 1, users: 1, 'users-jan1995': 1, data: 1, fw: 1,
    services: 1, service: 1, hosts: 1, passwd: 1, group: 1, quota: 1,
    netmasks: 1, networks: 1, resolv: 1, shell: 1, shells: 1
  };
  var TEXT_BASE = {
    fixperms: 1, ftpusers: 1, services: 1, shells: 1, hosts: 1, passwd: 1,
    group: 1, netmasks: 1, networks: 1, defaultrouter: 1, defaultdomain: 1,
    'xtacacsd-conf': 1, license: 1
  };

  /* Specific public documents at the repository root that canonical Markdown
     legitimately links to (relative to its own directory). Kept minimal and
     explicit; all other paths must live under ALLOWED_ROOTS. */
  var ROOT_FILES = {
    'README.md': 1, 'README.en.md': 1,
    'TRANSLATIONS.md': 1, 'TRANSLATIONS.en.md': 1,
    'LICENSE': 1
  };

  function baseOf(f) { var a = f.split('/'); return a[a.length - 1]; }
  function extOf(f) { var b = baseOf(f); var i = b.lastIndexOf('.'); return i === -1 ? '' : b.slice(i + 1).toLowerCase(); }
  function isMarkdown(f) { return MD_RE.test(f); }
  function isTextConfig(f) {
    var e = extOf(f);
    if (e && TEXT_EXT[e]) return true;
    return !!TEXT_BASE[baseOf(f).toLowerCase()];
  }

  /* ---- path policy ---------------------------------------------------- */
  function isAllowedFile(file) {
    if (typeof file !== 'string') return false;
    var f = file;
    try { f = decodeURIComponent(f); } catch (e) { return false; }
    if (!f) return false;
    if (f.indexOf('\0') !== -1) return false;
    if (f.indexOf('\\') !== -1) return false;                 // backslashes
    if (f.charAt(0) === '/' || f.indexOf('//') === 0) return false; // absolute / protocol-relative
    if (SCHEME_RE.test(f)) return false;                      // any URL scheme
    var segs = f.split('/');
    for (var i = 0; i < segs.length; i++) {
      if (segs[i] === '..' || segs[i] === '.' || segs[i] === '') return false;
    }
    if (!isMarkdown(f) && !isTextConfig(f)) return false;     // known textual content only
    if (!ROOT_FILES[f]) {                                     // explicit root documents, else under allowed roots
      var allowed = false;
      for (var j = 0; j < ALLOWED_ROOTS.length; j++) {
        if (f.indexOf(ALLOWED_ROOTS[j]) === 0) { allowed = true; break; }
      }
      if (!allowed) return false;
    }
    for (var k = 0; k < FORBIDDEN.length; k++) {
      var bad = FORBIDDEN[k];
      if (f.indexOf(bad) === 0 || f.indexOf('/' + bad) !== -1) return false;
    }
    return true;
  }

  function classify(file) {
    if (isMarkdown(file)) return 'markdown';
    if (isTextConfig(file)) return 'text';
    return null;
  }

  function dirname(p) {
    var i = p.lastIndexOf('/');
    return i === -1 ? '' : p.slice(0, i);
  }

  /* Browser URL of the repository root, derived from the current page URL.
     details.html lives at <repo>/site/details.html, so the repository root is
     one level up. Using URL APIs keeps this correct when the repository is
     served from a GitHub Pages project subdirectory (no leading "/"). */
  function repoBaseHref(locationHref) {
    return new URL('../', locationHref).href;
  }

  /* Browser URL for a repository-root-relative logical path. The `file=` query
     parameter is ALWAYS repository-root-relative; it is resolved against
     repoBaseHref, never against site/details.html directly and never as an
     absolute path. */
  function buildRepoURL(locationHref, repoPath) {
    var clean = String(repoPath).replace(/^\/+/, '');   // defensive: force repo-relative
    return new URL(clean, repoBaseHref(locationHref)).href;
  }

  function isExternal(href) {
    return SCHEME_RE.test(href) || href.indexOf('//') === 0;
  }

  /* Resolve an href/src found inside a Markdown file to a repository-root-relative,
     percent-encoded path.
     Resolution is ALWAYS against the SOURCE Markdown file's own directory (baseDir),
     never against site/details.html. `..` segments are normalised by the URL
     algorithm; any `..` that would go above the repository root is clamped to the
     root, so a link cannot escape the repository. */
  function resolveRepoPath(baseDir, href) {
    var base = 'http://repo.invalid/' + (baseDir ? baseDir + '/' : '');
    var u = new URL(href, base);
    return u.pathname.replace(/^\//, '');
  }

  /* Rewrite an anchor target. Markdown -> details.html?file=..., raw -> ../path */
  function rewriteHref(baseDir, href) {
    if (!href) return href;
    if (href.charAt(0) === '#') return href;                  // same-document anchor
    if (isExternal(href)) return href;                       // http(s)/mailto/tel/data/...
    var hi = href.indexOf('#');
    var path = hi === -1 ? href : href.slice(0, hi);
    var frag = hi === -1 ? '' : href.slice(hi);
    if (!path) return href;
    var resolved = resolveRepoPath(baseDir, path);
    if (MD_RE.test(resolved)) {
      return 'details.html?file=' + resolved + frag;
    }
    return '../' + resolved + frag;
  }

  /* Rewrite an image src to a repo-root-relative path from site/details.html */
  function rewriteSrc(baseDir, src) {
    if (!src) return src;
    if (isExternal(src) || src.indexOf('data:') === 0) return src;
    return '../' + resolveRepoPath(baseDir, src);
  }

  function slugify(s) {
    var t = String(s).trim().toLowerCase();
    if (t.normalize) t = t.normalize('NFKD').replace(/[\u0300-\u036f]/g, '');
    return t
      .replace(/[^\p{L}\p{N}\s-]/gu, '')
      .replace(/\s+/g, '-')
      .replace(/-+/g, '-')
      .replace(/^-+|-+$/g, '');
  }

  /* ---- rendering ------------------------------------------------------ */
  var state = { baseDir: '', slugs: {} };
  var rendererReady = false;

  function escAttr(s) {
    return String(s)
      .replace(/&/g, '&amp;').replace(/"/g, '&quot;')
      .replace(/</g, '&lt;').replace(/>/g, '&gt;');
  }

  function uniqueSlug(raw) {
    var base = slugify(raw) || 'section';
    if (!state.slugs[base]) { state.slugs[base] = 1; return base; }
    state.slugs[base] += 1;
    return base + '-' + state.slugs[base];
  }

  function setupRenderer() {
    if (rendererReady || !root.marked || !root.marked.Renderer) return;
    var r = new root.marked.Renderer();

    r.heading = function (textHtml, level, raw) {
      var id = uniqueSlug(raw || String(textHtml).replace(/<[^>]*>/g, ''));
      return '<h' + level + ' id="' + escAttr(id) + '">' + textHtml + '</h' + level + '>\n';
    };
    r.link = function (href, title, text) {
      var h = rewriteHref(state.baseDir, href);
      var attr = title ? ' title="' + escAttr(title) + '"' : '';
      var rel = isExternal(h) ? ' rel="noopener noreferrer"' : '';
      return '<a href="' + escAttr(h) + '"' + attr + rel + '>' + text + '</a>';
    };
    r.image = function (href, title, text) {
      var s = rewriteSrc(state.baseDir, href);
      var attr = title ? ' title="' + escAttr(title) + '"' : '';
      return '<img src="' + escAttr(s) + '" alt="' + escAttr(text || '') + '"' + attr + '>';
    };
    root.marked.use({ gfm: true, breaks: false, renderer: r });
    rendererReady = true;
  }

  function renderMarkdown(text, file) {
    setupRenderer();
    state.baseDir = dirname(file);
    state.slugs = {};
    return root.marked.parse(text);
  }

  function uiLang(file) {
    return /\.en\.md$/i.test(file) ? 'en' : 'it';
  }

  return {
    ALLOWED_ROOTS: ALLOWED_ROOTS,
    FORBIDDEN: FORBIDDEN,
    ROOT_FILES: ROOT_FILES,
    isAllowedFile: isAllowedFile,
    isMarkdown: isMarkdown,
    isTextConfig: isTextConfig,
    classify: classify,
    dirname: dirname,
    repoBaseHref: repoBaseHref,
    buildRepoURL: buildRepoURL,
    isExternal: isExternal,
    resolveRepoPath: resolveRepoPath,
    rewriteHref: rewriteHref,
    rewriteSrc: rewriteSrc,
    slugify: slugify,
    renderMarkdown: renderMarkdown,
    uiLang: uiLang
  };
});

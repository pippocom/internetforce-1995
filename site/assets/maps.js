/* Internetforce 1995–1996 — interactive map helpers (optional).
 * Navigation itself uses ordinary <a> links; this file only adds an
 * optional debug mode for hotspot alignment: ?debug=hotspots
 */
(function () {
  'use strict';
  var params;
  try { params = new URLSearchParams(window.location.search); } catch (e) { return; }
  if (params.get('debug') !== 'hotspots') return;

  var svg = document.querySelector('svg.map-overlay');
  if (!svg) return;
  svg.classList.add('debug');

  var anchors = svg.querySelectorAll('a.hotspot');
  for (var i = 0; i < anchors.length; i++) {
    var a = anchors[i];
    var rect = a.querySelector('rect');
    if (!rect) continue;
    var t = document.createElementNS('http://www.w3.org/2000/svg', 'text');
    t.setAttribute('x', String(Number(rect.getAttribute('x')) + 4));
    t.setAttribute('y', String(Number(rect.getAttribute('y')) + 22));
    t.setAttribute('class', 'debug-label');
    t.textContent = a.getAttribute('data-id') || '';
    svg.appendChild(t);
  }
})();

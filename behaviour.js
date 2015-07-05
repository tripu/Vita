
'use strict';

// Pseudo-constants:
var REGEX_DIR  = /─\ (.+\/)$/igm,
    REGEX_FILE = /─\ ([^\<].+[^\>])$/igm,
    REGEX_MD   = /\.md$/igm,
    REGEX_BASE = /tripu\.github\.io\/vita/i,
    NEW_BASE   = 'raw.githubusercontent.com/tripu/Vita/gh-pages',
    COMPLETE   = 'https://raw.githubusercontent.com/tripu/Vita/gh-pages/';

// Vars:
var md;

var embedLinks = function() {

  var lines = $('nav pre').text().split('\n'),
      path  = [],
      depth = 0,
      i, j, entry, newDepth, prefix;

  for (i in lines) {
    entry = REGEX_DIR.exec(lines[i]);

    if (entry && 2 === entry.length) {
      newDepth = (entry.index + 2) / 4;

      if (newDepth > depth) {
        path.push(entry[1]);
      } else if (newDepth === depth) {
        path[path.length - 1] = entry[1];
      } else {
        for (j = 0; j < depth - newDepth; j ++) {
          delete path[path.length - 1];
        }
      }

      depth = newDepth;
      lines[i] = lines[i].replace(REGEX_DIR, '─ <span>$1</span>');
    } else {
      entry = REGEX_FILE.exec(lines[i]);

      if (entry && 2 === entry.length) {
        newDepth = (entry.index - 2) / 4;

        if (newDepth < depth) {
          delete path[path.length - 1];
        }

        depth = newDepth;
        prefix = path.join('');
        lines[i] = lines[i].replace(REGEX_FILE, '─ <a id="' + prefix + '$1" href="#' + prefix + '$1">$1</a>');
      }
    }

  }

  $('nav pre').html(lines.join('\n'));

};

var showFile = function(event) {

  var url       = $(event.target).attr('id'),
      container = $('main');

  event.preventDefault();
  // document.location.hash = $(event.target).attr('href');
  // document.location.href = document.location.href + $(event.target).attr('href');

  $.get(url, function(data) {

    if (-1 !== url.search(REGEX_MD)) {
      container.html(md.render(data));
      container.removeClass('simple');
    } else {
      container.addClass('simple');
      container.text(data);
    }

  }).fail(function() {
    // url = url.replace(REGEX_BASE, NEW_BASE);
    url = COMPLETE + url;

    $.get(url, function(data) {

      if (-1 !== url.search(REGEX_MD)) {
        container.html(md.render(data));
        container.removeClass('simple');
      } else {
        container.addClass('simple');
        container.text(data);
      }

    });

  });

};

$(document).ready(function() {
  md = window.markdownit();
  embedLinks();
  $('nav a').click(showFile);
});


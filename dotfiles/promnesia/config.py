#!/usr/bin/env python3

from promnesia import Source
from promnesia.sources import auto
from promnesia.sources import guess
'''
List of sources to use

You can specify your own, add more sources, etc.
See https://github.com/karlicoss/promnesia#setup for more information
'''
SOURCES = [
    Source(
        auto.index,
        # just some arbitrary directory with html files
        '~/Dropbox/org-notes',

        name='org-nodes',

        ignored=[ '*.html', '*.glass', '*.jpeg', '*.png', '*.jpg', '*.py', '*.csv', '*.json', '*.org.organice-bak' ],
    ),

    Source(
        auto.index,
        # just some arbitrary directory with html files
        '~/.config/nixpkgs/dotfiles/doom-emacs',

        name='doom-emacs',

        ignored=[ '*.html', '*.glass', '*.jpeg', '*.png', '*.jpg', '*.el', '*.elc' ],
    ),
]

''' 
    Optional setting.
    A directory to keep intemediate caches in order to speed up indexing.
    If not specified, caching isn't used.
'''
CACHE_DIR = '/tmp/promnesia_cache/'

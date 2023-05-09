#!/bin/sh

# This is so gross, but I couldn't find a quicker way to fix this.
#
# tsc wants to write the imports exactly as they'll be in the javascript,
# while babel, which is used by the test too, jest, errors on imports to .js
#
# So my fix is to compile without the .js in the imports, then 'fix' them by
# adding them back in with a perl script. Sooooo gross.
find dest -name '*.js' -print | xargs perl -pe '/\.[cm]?js"/ || s/from "([^"]*)"/from "$1.js"/' -i.bak
find dest -name '*.bak' -print | xargs rm 


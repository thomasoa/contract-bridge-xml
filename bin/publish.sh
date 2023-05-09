#!/bin/sh

[ -d dest ] || echo 'Directory ./dest does not exist'
[ -d dest ] || exit

perl -pe '/\.js"/ || s/from "([^"]*)"/from "$1.js"/' -i.bak dest/*/*.js
find ./dest -name '*.bak' -print | xargs rm 

[ -d ../thomasoa.github.io ] || exit 0
( cd dest ; tar cf - .) | (cd ../thomasoa.github.io/impossible; tar xvf -)
cd ../thomasoa.github.io
git add .
git commit -m "IBBJS: $*"
git push


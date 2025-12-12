#!/bin/sh

f=`realpath $1`
mv .git /tmp
mv debian /tmp
rm -rf *
rm -rf .*
here=$PWD

rm -rf /tmp/a
mkdir /tmp/a
cd /tmp/a
tar xf $f
for d in `ls`; do
    cp -rp $d/* $here/
done

mv /tmp/.git $here/
mv /tmp/debian $here/

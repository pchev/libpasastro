#!/bin/bash

destdir=$PREFIX

if [ -z "$destdir" ]; then
   export destdir=/tmp/libpasastro
fi

echo Install LibPasAstro to $destdir

install -m 755 -d $destdir
install -m 755 -d $destdir/lib
install -m 755 -d $destdir/share
install -m 755 -d $destdir/share/doc
install -m 755 -d $destdir/share/doc/libpasastro

install -v -m 644 -s getdss/libpasgetdss.so.*  $destdir/lib/
install -v -m 644 -s plan404/libpasplan404.so.*  $destdir/lib/
install -v -m 644 -s wcs/libpaswcs.so.*  $destdir/lib/
install -v -m 644 changelog $destdir/share/doc/libpasastro/changelog
install -v -m 644 copyright $destdir/share/doc/libpasastro/copyright

cd $destdir/lib
ln -s libpasgetdss.so.1.1 libpasgetdss.so.1
ln -s libpasplan404.so.1.1 libpasplan404.so.1
ln -s libpaswcs.so.1.1 libpaswcs.so.1


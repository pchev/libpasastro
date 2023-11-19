#!/bin/bash 

version=1.4.2

builddir=/tmp/libpasastro  # Be sure this is set to a non existent directory, it is removed after the run!

arch=$(uname -m)

wd=`pwd`

currentrev=$(git rev-list --count --first-parent HEAD)
if [[ -z $currentrev ]]; then currentrev=1; fi

# delete old files
  rm libpasastro*.xz
  rm -rf $builddir

# make FreeBSD version
  gmake clean all
  if [[ $? -ne 0 ]]; then exit 1;fi
  gmake install PREFIX=$builddir
  if [[ $? -ne 0 ]]; then exit 1;fi
  # tar
  cd $builddir
  cd ..
  tar cvJf libpasastro-$version-$currentrev-FreeBSD_$arch.tar.xz libpasastro
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasastro*.tar.xz $wd
  if [[ $? -ne 0 ]]; then exit 1;fi

cd $wd
rm -rf $builddir


#!/bin/bash 

version=1.0

builddir=/tmp/libpasastro  # Be sure this is set to a non existent directory, it is removed after the run!

arch=$(uname -m)

wd=`pwd`

# check if new revision since last run
read lastrev <last.build
currentrev=$(LANG=C svn info . | grep Revision: | sed 's/Revision: //')
if [[ -z $currentrev ]]; then 
 currentrev=0
fi
echo $lastrev ' - ' $currentrev
if [[ $lastrev -ne $currentrev ]]; then

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

# store revision 
  echo $currentrev > last.build
else
  echo Already build at revision $currentrev
  exit 4
fi


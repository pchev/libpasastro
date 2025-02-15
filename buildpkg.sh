#!/bin/bash 

version=1.4.3

builddir=/tmp/libpasastro  # Be sure this is set to a non existent directory, it is removed after the run!

arch=$(arch)

# adjuste here the target you want to crossbuild

unset make_linux32
unset make_linux64
unset make_linuxarm
unset make_linuxaarch64

if [[ $arch == i686 ]]; then 
   make_linux32=1
fi
if [[ $arch == x86_64 ]]; then 
   make_linux64=1
fi
if [[ $arch == armv7l ]]; then 
   make_linuxarm=1
fi
if [[ $arch == aarch64 ]]; then 
   make_linuxaarch64=1
   make_linuxarm=1
fi


save_PATH=$PATH
wd=`pwd`

currentrev=$(git rev-list --count --first-parent HEAD)
if [[ -z $currentrev ]]; then currentrev=1; fi

# delete old files
  rm libpasastro*.xz
  rm libpasastro*.deb
  rm libpasastro*.rpm
  rm -rf $builddir

# make Linux i386 version
if [[ $make_linux32 ]]; then
  make CPU_TARGET=i386 OS_TARGET=linux clean
  make CPU_TARGET=i386 OS_TARGET=linux
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install PREFIX=$builddir
  # tar
  cd $builddir
  cd ..
  tar cvJf libpasastro-$version-$currentrev-linux_i386.tar.xz libpasastro
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasastro*.tar.xz $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # deb
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/debian $builddir
  cd $builddir
  mkdir debian/libpasastro/usr
  mv lib debian/libpasastro/usr/
  mv share debian/libpasastro/usr/
  cd debian
  sz=$(du -s libpasastro/usr | cut -f1)
  sed -i "s/%size%/$sz/" libpasastro/DEBIAN/control
  sed -i "/Version:/ s/1/$version-$currentrev/" libpasastro/DEBIAN/control
  fakeroot dpkg-deb -Zxz --build libpasastro .
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasastro*.deb $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # rpm
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/rpm $builddir
  cd $builddir
  mkdir -p rpm/libpasastro/usr/
  mv debian/libpasastro/usr/* rpm/libpasastro/usr/
  cd rpm
  sed -i "/Version:/ s/1/$version/"  SPECS/libpasastro.spec
  sed -i "/Release:/ s/1/$currentrev/" SPECS/libpasastro.spec
  setarch i386 fakeroot rpmbuild  --buildroot "$builddir/rpm/libpasastro" --define "_topdir $builddir/rpm/" --define "_binary_payload w7.xzdio" -bb SPECS/libpasastro.spec
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv RPMS/i386/libpasastro*.rpm $wd
  if [[ $? -ne 0 ]]; then exit 1;fi

  cd $wd
  rm -rf $builddir
fi

# make Linux x86_64 version
if [[ $make_linux64 ]]; then
  make CPU_TARGET=x86_64 OS_TARGET=linux clean
  make CPU_TARGET=x86_64 OS_TARGET=linux
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install PREFIX=$builddir
  if [[ $? -ne 0 ]]; then exit 1;fi
  # tar
  cd $builddir
  cd ..
  tar cvJf libpasastro-$version-$currentrev-linux_x86_64.tar.xz libpasastro
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasastro*.tar.xz $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # deb
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/debian $builddir
  cd $builddir
  mkdir debian/libpasastro64/usr
  mv lib debian/libpasastro64/usr/
  mv share debian/libpasastro64/usr/
  cd debian
  sz=$(du -s libpasastro64/usr | cut -f1)
  sed -i "s/%size%/$sz/" libpasastro64/DEBIAN/control
  sed -i "/Version:/ s/1/$version-$currentrev/" libpasastro64/DEBIAN/control
  fakeroot dpkg-deb -Zxz --build libpasastro64 .
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasastro*.deb $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # rpm
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/rpm $builddir
  cd $builddir
  mkdir -p rpm/libpasastro/usr/
  mv debian/libpasastro64/usr/* rpm/libpasastro/usr/
  # Redhat 64bits lib is lib64
  mv rpm/libpasastro/usr/lib rpm/libpasastro/usr/lib64
  cd rpm
  sed -i "/Version:/ s/1/$version/"  SPECS/libpasastro64.spec
  sed -i "/Release:/ s/1/$currentrev/" SPECS/libpasastro64.spec
# rpm 4.7
  fakeroot rpmbuild  --buildroot "$builddir/rpm/libpasastro" --define "_topdir $builddir/rpm/" --define "_binary_payload w7.xzdio"  -bb SPECS/libpasastro64.spec
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv RPMS/x86_64/libpasastro*.rpm $wd
  if [[ $? -ne 0 ]]; then exit 1;fi

  cd $wd
  rm -rf $builddir
fi

# make Linux arm version
if [[ $make_linuxarm ]]; then
  make CPU_TARGET=armv OS_TARGET=linux clean
  make CPU_TARGET=armv OS_TARGET=linux
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install PREFIX=$builddir
  if [[ $? -ne 0 ]]; then exit 1;fi
  # tar
  cd $builddir
  cd ..
  tar cvJf libpasastro-$version-$currentrev-linux_armhf.tar.xz libpasastro
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasastro*.tar.xz $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # deb
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/debian $builddir
  cd $builddir
  mkdir debian/libpasastroarm/usr
  mv lib debian/libpasastroarm/usr/
  mv share debian/libpasastroarm/usr/
  cd debian
  sz=$(du -s libpasastroarm/usr | cut -f1)
  sed -i "s/%size%/$sz/" libpasastroarm/DEBIAN/control
  sed -i "/Version:/ s/1/$version-$currentrev/" libpasastroarm/DEBIAN/control
  fakeroot dpkg-deb -Zxz --build libpasastroarm .
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasastro*.deb $wd
  if [[ $? -ne 0 ]]; then exit 1;fi

  cd $wd
  rm -rf $builddir
fi

# make Linux arm64 version
if [[ $make_linuxaarch64 ]]; then
  make CPU_TARGET=aarch64 OS_TARGET=linux clean
  make CPU_TARGET=aarch64 OS_TARGET=linux
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install PREFIX=$builddir
  if [[ $? -ne 0 ]]; then exit 1;fi
  # tar
  cd $builddir
  cd ..
  tar cvJf libpasastro-$version-$currentrev-linux_arm64.tar.xz libpasastro
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasastro*.tar.xz $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # deb
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/debian $builddir
  cd $builddir
  mkdir debian/libpasastroarm64/usr
  mv lib debian/libpasastroarm64/usr/
  mv share debian/libpasastroarm64/usr/
  cd debian
  sz=$(du -s libpasastroarm64/usr | cut -f1)
  sed -i "s/%size%/$sz/" libpasastroarm64/DEBIAN/control
  sed -i "/Version:/ s/1/$version-$currentrev/" libpasastroarm64/DEBIAN/control
  fakeroot dpkg-deb -Zxz --build libpasastroarm64 .
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasastro*.deb $wd
  if [[ $? -ne 0 ]]; then exit 1;fi

  cd $wd
  rm -rf $builddir
fi

cd $wd


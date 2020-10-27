Summary: Provide shared libraries to interface Pascal program with standard astronomy libraries
Name: libpasastro
Version: 1
Release: 1
Group: Sciences/Astronomy
License: GPLv2+
URL: http://libpasastro.sourceforge.net
Packager: Patrick Chevalley
BuildRoot: %_topdir/%{name}
BuildArch: i386
Provides: libpasgetdss.so libpasplan404.so libpaswcs.so
AutoReqProv: no

%description
Provide shared libraries to interface Pascal program with standard astronomy libraries.
 libpasgetdss.so : Interface with GetDSS to work with DSS images.
 libpasplan404.so: Interface with Plan404 to compute planets position.
 libpaswcs.so    : Interface with libwcs to work with FITS WCS.
 libpasspice.so  : To work with NAIF/SPICE kernel

%files
%defattr(-,root,root)
/usr/lib/libpasgetdss.so.1.1
/usr/lib/libpasplan404.so.1.1
/usr/lib/libpaswcs.so.1.1
/usr/lib/libpasspice.so.1.1
/usr/lib/libpasgetdss.so.1
/usr/lib/libpasplan404.so.1
/usr/lib/libpaswcs.so.1
/usr/lib/libpasspice.so.1
/usr/share/doc/libpasastro

%post
/sbin/ldconfig

%postun
/sbin/ldconfig

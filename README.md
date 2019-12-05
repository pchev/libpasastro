# libpasastro
Interface to standard astronomy library for use from Pascal program

Provide shared libraries to interface Pascal program with standard astronomy libraries.
- libpasgetdss.so : Interface with GetDSS to work with DSS images.
- libpasplan404.so: Interface with Plan404 to compute planets position.
- libpaswcs.so : Interface with libwcs to work with FITS WCS.
- libpasraw.so : Interface with libraw to decode camera raw files.

This libraries are used with the following projects:
- skychart
- ccdciel
- virtualplanet
- virtualmoon

Please report any issue at https://www.ap-i.net/mantis/set_project.php?project_id=7

You can download pre-compiled binary without libpasraw.so from https://sourceforge.net/projects/libpasastro/    

Install version with camera raw file support from https://launchpad.net/~pch/+archive/ubuntu/ppa-skychart

### Compilation

You need git, gcc, g++ , make, and libraw-dev

This can be installed with the command:
<pre>
sudo apt install git build-essential libraw-dev
</pre>

Get the source code:
<pre>
git clone https://github.com/pchev/libpasastro.git
cd libpasastro
</pre>

Then run:
<pre>
make
sudo make install PREFIX=/usr
</pre>


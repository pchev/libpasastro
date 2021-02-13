#
#   Makefile for LibPasAstro 1.0
#

.PHONY: all

all:
ifeq ($(OS_TARGET),win32)
	$(MAKE) -C getdss -f Makefile.win32 all 
	$(MAKE) -C plan404 -f Makefile.win32 all 
	$(MAKE) -C wcs -f Makefile.win32 all
 else
 ifeq ($(OS_TARGET),win64)
	$(MAKE) -C getdss -f Makefile.win64 all 
	$(MAKE) -C plan404 -f Makefile.win64 all 
	$(MAKE) -C wcs -f Makefile.win64 all
 else
 ifeq ($(CPU_TARGET),i386)
	$(MAKE) -C getdss all arch_flags=-m32
	$(MAKE) -C plan404 all arch_flags=-m32
	$(MAKE) -C wcs all arch_flags=-m32
 else
 ifeq ($(CPU_TARGET),x86_64)
	$(MAKE) -C getdss all arch_flags=-m64
	$(MAKE) -C plan404 all arch_flags=-m64
	$(MAKE) -C wcs all arch_flags=-m64
 else
	$(MAKE) -C getdss all
	$(MAKE) -C plan404 all
	$(MAKE) -C wcs all
 endif
 endif
 endif
endif

clean:
ifeq ($(OS_TARGET),win32)
        $(MAKE) -C getdss -f Makefile.win32 clean
        $(MAKE) -C plan404 -f Makefile.win32 clean
        $(MAKE) -C wcs -f Makefile.win32 clean
else
ifeq ($(OS_TARGET),win64)
        $(MAKE) -C getdss -f Makefile.win64 clean 
        $(MAKE) -C plan404 -f Makefile.win64 clean
        $(MAKE) -C wcs -f Makefile.win64 clean
else
	$(MAKE) -C getdss clean
	$(MAKE) -C plan404 clean
	$(MAKE) -C wcs clean
endif
endif

ifeq ($(OS_TARGET),darwin)
install: 
	./install_darwin.sh $(PREFIX)
else
install: 
	./install.sh $(PREFIX) $(CPU_TARGET)
install_win: 
	./install_win.sh win32 $(PREFIX)
install_win64:
	./install_win.sh win64 $(PREFIX)
endif

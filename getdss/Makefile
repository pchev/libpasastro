
CPPFLAGS=-I. -O3 -fPIC $(arch_flags)
#### For Suns and similar wrong-endian computers, add -DWRONG_WAY_BYTE_ORDER.
OSTYPE = $(shell uname)
ifneq ($(findstring BSD,$(OSTYPE)),)
CC            = cc
else
CC            = gcc
endif
ifneq ($(findstring Darwin,$(OSTYPE)),)
SO_Name = libgetdss.dylib
LDFLAGS=  -Wl,-single_module -dynamiclib  -lc -lm -lstdc++ -mmacosx-version-min=10.6
else
SOName = libpasgetdss.so.1
SO_Name = libpasgetdss.so.1.1
LDFLAGS= -shared -Wl,-soname,$(SOName) $(arch_flags)
endif

OBJS = getdss_lib.o dss.o extr_fit.o getpiece.o \
	hdcmprss.o bitinput.o decode.o dodecode.o hinv.o \
	platelst.o qtreedec.o
LIBS = -lm -lstdc++

all: $(SO_Name)

$(SO_Name):  $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)
	
clean:
	rm -f $(OBJS) $(SO_Name)

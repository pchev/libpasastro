# 
CFLAGS= -DLIBRAW_NOTHREADS -O3  -w -fPIC $(arch_flags)
OSTYPE = $(shell uname)
ifneq ($(findstring BSD,$(OSTYPE)),)
CXX           = c++
else
CXX           = g++
endif
ifneq ($(findstring Darwin,$(OSTYPE)),)
SO_Name       = libpasraw.dylib
LIBFLAGS      = -Wl,-single_module -dynamiclib  -lc -lm -mmacosx-version-min=10.6
else
SOName        = libpasraw.so.1
SO_Name       = libpasraw.so.1.1
LIBFLAGS      = -shared -Wl,-soname,$(SOName) 
endif
ifneq ($(findstring W32,$(OSTYPE)),)
SO_Name       = libpasraw.dll
LIBFLAGS      = -shared -Wl,-soname,$(SO_Name) 
endif
ifneq ($(findstring MINGW,$(OSTYPE)),)
SO_Name       = libpasraw.dll
LIBFLAGS      = -shared -Wl,-soname,$(SO_Name) 
endif

OBJS =	pasraw.cpp 
LIBS = -lraw

all: $(SO_Name)

$(SO_Name): $(OBJS)
	$(CXX) $(CFLAGS) $(LIBFLAGS) -o $@ $(OBJS) $(LIBS)

clean:
	rm -f *.a *.o $(SO_Name)

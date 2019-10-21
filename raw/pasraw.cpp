/* File pasraw.cpp
   
   Shared library for using Libraw from Pascal program
   
   The function is limited to get raw non processed image
   to help convertion to FITS
   
*/

#include "libraw/libraw.h"

struct TImgInfo
{
   int rawwidth;
   int rawheight;
   int imgwidth;
   int imgheight;
   int topmargin;
   int leftmargin;
   unsigned short *bitmap;
};

LibRaw RawProcessor;
#define S RawProcessor.imgdata.sizes

extern "C" int loadraw(char *rawinput, int inputsize)
{
    int ret;
    if (ret = RawProcessor.open_buffer(rawinput, inputsize) != LIBRAW_SUCCESS)
    {
      return(ret);
    }
    if ((ret = RawProcessor.unpack()) != LIBRAW_SUCCESS)
    {
      return(ret);
    }

    if (!(RawProcessor.imgdata.idata.filters || RawProcessor.imgdata.idata.colors == 1))
    {
      return(-1);
    }
    return(0);
}

extern "C" int closeraw()
{
    RawProcessor.recycle(); 
    return(0);
}    

extern "C" int getinfo(TImgInfo *info)
{
   if ((!S.raw_width)&&(!S.raw_height)) {
     return(1);
   }
   info->rawwidth = S.raw_width;
   info->rawheight = S.raw_height;
   info->imgwidth = S.width;
   info->imgheight = S.height;
   info->topmargin = S.top_margin;
   info->leftmargin = S.left_margin;
   info->bitmap = RawProcessor.imgdata.rawdata.raw_image;
   return(0);
}    

extern "C"  void geterrormsg(int ret, char *msg)
{
    sprintf(msg,"%s",libraw_strerror(ret));
}   

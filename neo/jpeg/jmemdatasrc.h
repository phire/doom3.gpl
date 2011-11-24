#ifndef JMEMDATASRC_H
#define JMEMDATASRC_H
#include <stddef.h>
#include <stdio.h>
#include <jpeglib.h>

#ifdef __cplusplus
extern "C" {
#endif

void
jpeg_memory_src (j_decompress_ptr cinfo, unsigned char *inBuffer, int size);

#ifdef __cplusplus
} // extern "C"
#endif

#endif // JMEMDATASRC_H

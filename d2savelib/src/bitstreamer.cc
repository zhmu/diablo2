/*
 * Diablo2 Save Game Library 1.0 - bitstreamer.cc
 * (c) 2008 Rink Springer <mail@rink.nu>
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "bitstreamer.h"

BitStreamer::BitStreamer() 
{
	data = NULL; datalen = 0; curbit = 0; curpos = 0;
}

BitStreamer::~BitStreamer()
{
	free();
}

void
BitStreamer::load(const char* fname)
{
	FILE* f;

	free();

	f = fopen(fname, "rb");
	if (f == NULL)
		throw BitStreamError(BS_ERR_FILE);

	fseek(f, 0, SEEK_END);
	datalen = ftell(f);
	rewind(f);

	data = (uint8_t*)malloc(datalen);
	if (data == NULL)
		throw BitStreamError(BS_ERR_MEMORY);

	if (!fread(data, datalen, 1, f))
		throw BitStreamError(BS_ERR_FILE);

	fclose(f);

	curpos = 0; curbit = 0;
}

void
BitStreamer::setData(const void* buf, size_t buflen)
{
	free();
	if (buflen == 0)
		return;

	data = (uint8_t*)malloc(buflen);
	if (data == NULL)
		throw BitStreamError(BS_ERR_MEMORY);
	memcpy(data, buf, buflen);
	datalen = buflen;
}

void
BitStreamer::free()
{
	datalen = 0;
	if (data == NULL)
		return;
	::free((void*)data);
	data = NULL;
}
	
uint32_t
BitStreamer::read(size_t bits)
{
	if (bits > 32)
		throw BitStreamError(BS_ERR_ARG);

	// Ensure we are not trying to read beyond the length of the stream
	int bytesneeded = (bits / 8);
	if (!bytesneeded)
		bytesneeded++;
	if (curpos + bytesneeded > datalen)
		throw BitStreamError(BS_ERR_EOS);

	/*
	 * All specifications in use explicit (uint32_t) casts. This means that
	 * the data is converted internally to Little Endian (as least on
	 * Intel CPU's). In order to obey the specification, we reconstruct such a
	 * 32 bit value, or at least the significant part.
	 */
	uint32_t val = (uint32_t)data[curpos];
	if (curpos + 3 < datalen)
		val |= (uint32_t)data[curpos+3] << 24;
	if (curpos + 2 < datalen)
		val |= (uint32_t)data[curpos+2] << 16;
	if (curpos + 1 < datalen)
		val |= (uint32_t)data[curpos+1] << 8;

	/*
	 * We are currently curbit bits deep in the value, so throw the
	 * last curbit bits away (last due to endianness)u
	 */
	val >>= curbit;

	/*
	 * Now, return only the bits asked for - this is equivalent with
	 * throwing bits [31 .. bits + 1] away.
	 */
	val &= ((1 << bits) - 1);
	skip(bits);
	return val;
}

void
BitStreamer::skip(size_t bits)
{
	curbit += bits;
	while (curbit >= 8) {
		curpos++;
		curbit -= 8;
	}
}

void
BitStreamer::seek(off_t offs)
{
	curbit = 0; curpos = 0;
	skip(offs);
}

void
BitStreamer::dump()
{
	printf("curbit=%u,curpos=%u\n", curbit, curpos);
}

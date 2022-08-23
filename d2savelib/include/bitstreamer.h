/*
 * Diablo2 Save Game Library 1.0 - bitstreamer.h
 * (c) 2008, 2009 Rink Springer <mail@rink.nu>
 */
#include <stdint.h>

#ifndef __BITSTREAMER_H__
#define __BITSTREAMER_H__

enum BitStreamErrorCode {
	BS_ERR_UNKNOWN = 0,
	BS_ERR_FILE,
	BS_ERR_MEMORY,
	BS_ERR_EOS,
	BS_ERR_ARG
};

//! \brief Class used to handle bitstream errors
class BitStreamError
{
public:
	inline BitStreamError(BitStreamErrorCode value) { errcode = value; }
	inline BitStreamErrorCode getErrorCode() { return errcode; }
	const char* getErrorMessage();

private:
	BitStreamErrorCode errcode;
};

//! \brief Utility class to handle reading/writing streams of bits
class BitStreamer
{
public:
	BitStreamer();
	~BitStreamer();

	/*! \brief Loads a file
	 *  \param fname The file to load
	 *  \throws BitStreamError on failure
	 */
	void load(const char* fname);

	/*! \brief Writes streamer content to disk
	 *  \param fname File to write to
	 *  \throws BitStreamError on failure
	 */
	void save(const char* fname);

	/*! \brief Uses a specified buffer as data
	 *  \param buf Buffer to use
	 *  \param buflen Length of the buffer to use
	 *  \throws BitStreamError on failure
	 */
	void setData(const void* buf, size_t buflen);

	//! \brief Frees the current data
	void free();

	/*! \brief Reads a specified number of bits
	 *  \param bits The number of bits to skip
	 *  \returns The number of bits read
	 *  \throws BitStreamError on failure
	 *
	 *  This function wil not return more than 32 bits at a time
	 */
	uint32_t read(size_t bits);

	/*! \brief Skips a specified number of bits
	 *  \param bits The number of bits to skip
	 *
	 *  Any number of bits can be skipped, but end-of-stream
	 *  errors will be reported at the next read.
	 */
	void skip(size_t bits);

	/*! \brief Skips a specified number of bytes
	 *  \param bytes The number of bytes to skip
	 *
	 *  Any number of bytes can be skipped, but end-of-stream
	 *  errors will be reported at the next read.
	 */
	inline void skipByte(size_t bytes) { skip(bytes * 8); }

	/*! \brief Seeks to a specified bit position
	 *  \param offs Bit offset to seek to
	 *
	 *  You can see to any bit position, but subsequent
	 *  reads may yield an end-of-stream error.
	 */
	void seek(off_t offs);

	/*! \brief Seeks to a specified byte position
	 *  \param offs Byte offset to seek to
	 *
	 *  You can see to any byte position, but subsequent
	 *  reads may yield an end-of-stream error.
	 */
	inline void seekByte(off_t offs) { seek(offs * 8); }

	//! \brief Returns the length of the data in use
	inline size_t getDataLength() { return datalen; }

	//! \brief Returns the current bit position in the savegame
	inline off_t tell() { return (curpos * 8) + curbit; }

	//! \brief Seeks to the next full byte
	inline void seekNextByte() {
		while (curbit != 0)
			skip(1);
	}

	/*! \brief Reads the next 8 bit value
	 *  \throws BitStreamError on failure
	 */
	inline uint8_t read8() { return read(8); }

	/*! \brief Checks if the end of stream is encountered
	 *  \returns Non-zero if the stream ends, zero if not
	 */
	inline int isEOS() { return curpos == datalen; }

	/*! \brief Reads the next 16 bit little endian value
	 *  \throws BitStreamError on failure
	 */
	inline uint16_t readLE16() {
		uint16_t v = read8();
		v |= (uint16_t)read8() << 8;
		return v;
	}

	/*! \brief Reads the next 32 bit little endian value
	 *  \throws BitStreamError on failure
	 */
	inline uint32_t readLE32() {
		uint32_t v = readLE16();
		v |= (uint32_t)readLE16() << 16;
		return v;
	}

	void dump();

private:
	uint8_t*	data;
	size_t		datalen;
	size_t		curpos;
	int		curbit;
};

#endif /* __BITSTREAMER_H__ */

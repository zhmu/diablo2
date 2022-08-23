#include <sys/types.h>
#include <stdio.h>
#include "bitstreamer.h"
#include "item.h"

#define VERSION 110

BitStreamer bs;
Item it(&bs, VERSION);

int
main(int argc, char** argv)
{

	if (argc != 2) {
		printf("usage: i2test file.d2i\n");
		return 1;
	}
	try {
		bs.load(argv[1]);
		it.load();

		it.dump();
		return 0;
	} catch (BitStreamError bse) {
		printf("bitstream.error=%u\n", bse.getErrorCode());
#if 0
	} catch (SavegameError sge) {
		printf("savegame.error=%u\n", sge.getErrorCode());
#endif
	}
	return 1;
}

#!/usr/bin/perl -w

use strict;

print "#include <stdlib.h>
#include \"item.h\"

struct ITEMPROPERTY itemprops[] = {
";

open F, "<ItemStatCost.txt" or die;
<F>;
while(<F>) {
        chop; my @a = split(/\t/);
	my ($savebits109, $saveadd109)  = ($a[19], $a[20]);
	my ($savebits110, $saveadd110)  = ($a[21], $a[22]);
	next if not $savebits109 and not $savebits110;
	$savebits109 = 0 unless $savebits109;
	$saveadd109 = 0 unless $saveadd109;
	$savebits110 = $savebits109 unless $savebits110;
	$saveadd110 = $saveadd109 unless $saveadd110;
	$savebits110 += $a[23] if $a[23];
        printf "\t{ %s, \"%s\", ITEMVAL_STD, %s, %s, %s, %s, FOLLOW_NONE, FOLLOW_NONE }, \n", $a[1], $a[0], $savebits109, $saveadd109, $savebits110, $saveadd110;
}
printf "\t{ NULL, 0, 0, 0, FOLLOW_NONE, FOLLOW_NONE }
};
";
close F;


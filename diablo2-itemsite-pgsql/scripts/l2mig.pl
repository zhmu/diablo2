#!/usr/bin/perl -w

use DBI;
use strict;

our $DB = DBI->connect($OLDDB_DSN, $OLDDB_USER, $OLDDB_PASS) or die;

my @level;
my $sth = $DB->prepare("SELECT id, exp_req FROM levels");
$sth->execute or die;
while (my ($id, $exp) = $sth->fetchrow_array()) {
	$level[$id] = $exp;
}

for (my $i = 2; $i <= 99; $i++) {
	print "$i: " . $level[$i] . "\t\t" . ($level[$i] - $level[$i - 1]) . "\n";
}

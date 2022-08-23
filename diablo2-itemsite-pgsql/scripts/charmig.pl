#!/usr/bin/perl -w

use DBI;
use strict;

require "config.pl";

my %CLASSMAP = (
	"Amazon" => "am",
	"Assassin" => "as",
	"Barbarian" => "ba",
	"Druid" => "dr",
	"Necromancer" => "ne",
	"Paladin" => "pa",
	"Sorceress" => "so"
);

our $olddb = DBI->connect($OLDDB_DSN, $OLDDB_USER, $OLDDB_PASS) or die;
my $DB = DBI->connect($DB_DSN, $DB_USER, $DB_PASS) or die;

my $iowner_sth = $olddb->prepare("SELECT item_id,item_type FROM item_owner WHERE owner_id=?");
my $unique_sth = $olddb->prepare("SELECT name FROM unique_items WHERE id=?");
my $set_sth = $olddb->prepare("SELECT name FROM set_items WHERE id=?");
my $char_sth = $olddb->prepare("SELECT c.id,c.name,t.name,l.id FROM characters c,char_types t,levels l WHERE c.type=t.id AND c.experience>=l.exp_req AND c.experience<=l.exp_next");

my $addchar_sth = $DB->prepare("INSERT INTO charachter (class,name,level) VALUES (?,?,?)");
my $getchar_sth = $DB->prepare("SELECT charid FROM charachter WHERE name=?");
my $finditem_sth = $DB->prepare("SELECT itemid FROM item WHERE name=?");
my $additem_sth = $DB->prepare("INSERT INTO char_item (charid,itemid) VALUES (?,?)");

$char_sth->execute or die;
while (my ($cid, $name, $class, $level) = $char_sth->fetchrow_array()) {
	my $cl = $CLASSMAP{$class} or die;
	print "$cid:$name:$cl:$level\n";

	$addchar_sth->execute($cl,$name,$level) or die;
	$getchar_sth->execute($name) or die;
	my ($charid) = $getchar_sth->fetchrow_array();
	die unless $charid;

	$iowner_sth->execute($cid) or die;
	while (my ($itemid, $itemtype) = $iowner_sth->fetchrow_array()) {
		my $sth = undef;
		if ($itemtype == 1) { $sth = $unique_sth; }
		if ($itemtype == 2) { $sth = $set_sth; }
		$sth->execute($itemid) or die;
		my ($iname) = $sth->fetchrow_array();
		die "Item [$iname] not found!" unless $iname;

		$finditem_sth->execute($iname) or die;
		my ($newitemid) = $finditem_sth->fetchrow_array();
		die unless $newitemid;
		$additem_sth->execute($charid, $newitemid) or die;
	}
}

#!/usr/bin/perl -w

use DBI;
use strict;

require "config.pl";

our ($DB_DSN, $DB_USER, $DB_PASS);
my $DB = DBI->connect($DB_DSN, $DB_USER, $DB_PASS) or die;

my %charmap = (	
	"amazon" => "am",
	"assasin" => "as",
	"assassin" => "as",
	"barbarian" => "ba",
	"druid" => "dr",
	"necromancer" => "ne",
	"paladin" => "pa",
	"sorceress" => "so",
);

my $getspell_sth = $DB->prepare("SELECT spellid FROM spell WHERE name=?");
my $updspell_sth = $DB->prepare("UPDATE spell SET charachter=? WHERE spellid=?");
my $addspell_sth = $DB->prepare("INSERT INTO spell (name,charachter) VALUES (?,?)");
my $getitemprop_sth = $DB->prepare("SELECT itemid,value,value_min,value_max FROM item_item_prop WHERE itempropid=?");
my $addspellprop_sth = $DB->prepare("INSERT INTO item_spell (itemid,spellid,type,level_val,level_min,level_max) VALUES (?,?,?,?,?,?)");

my $zapip_sth = $DB->prepare("DELETE FROM item_item_prop WHERE itempropid=?");
my $zapp_sth = $DB->prepare("DELETE FROM itemproperty WHERE itempropid=?");

my $prop_sth = $DB->prepare("SELECT itempropid,name FROM itemproperty WHERE name LIKE '% only)' OR name LIKE '% Only)'");
$prop_sth->execute or die;

while (my ($propid, $name) = $prop_sth->fetchrow_array()) {
	die unless $name =~ /^(.+) \((.+) Only\)$/i;
	my ($spell, $char) = ($1, $2);
	
	my $ch = $charmap{lc($char)};
	die "No such char defined '$char'" unless $ch;

	$getspell_sth->execute($spell) or die;
	my ($spellid) = $getspell_sth->fetchrow_array();
	if (not defined $spellid) {
		$addspell_sth->execute($spell, $ch) or die;
		$getspell_sth->execute($spell) or die;
		($spellid) = $getspell_sth->fetchrow_array() or die;
	} else {
		$updspell_sth->execute($ch, $spellid) or die;
	}

	$getitemprop_sth->execute($propid) or die;
	while (my ($itemid, $val, $min, $max) = $getitemprop_sth->fetchrow_array()) {
		$addspellprop_sth->execute($itemid, $spellid, "S", $val, $min, $max) or die;
	}

	$zapip_sth->execute($propid) or warn;
	$zapp_sth->execute($propid) or warn;
}

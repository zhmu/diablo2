#!/usr/bin/perl -w

use DBI;
use strict;

require "config.pl";

our ($DB_DSN, $DB_USER, $DB_PASS);
my $DB = DBI->connect($DB_DSN, $DB_USER, $DB_PASS) or die;

#$DB->do('DELETE FROM item_spell');

my $getspell_sth = $DB->prepare("SELECT spellid FROM spell WHERE name=?");
my $addspell_sth = $DB->prepare("INSERT INTO spell (name) VALUES (?)");
my $getitemprop_sth = $DB->prepare("SELECT itemid,value,value_min,value_max FROM item_item_prop WHERE itempropid=?");
my $addspellprop_sth = $DB->prepare("INSERT INTO item_spell (itemid,spellid,type,level_val,level_min,level_max,pct_val,pct_min,pct_max,num_charges) VALUES (?,?,?,?,?,?,?,?,?,?)");
my $prop_sth = $DB->prepare("SELECT itempropid,name FROM itemproperty WHERE name LIKE '% Chance to%' OR name LIKE '% Chance To%' OR name LIKE 'Charges: %'");
$prop_sth->execute or die;

my $zapip_sth = $DB->prepare("DELETE FROM item_item_prop WHERE itempropid=?");
my $zapp_sth = $DB->prepare("DELETE FROM itemproperty WHERE itempropid=?");

while (my ($propid, $name) = $prop_sth->fetchrow_array()) {
	if ($name =~ /^% Chance to Cast Level (\d+) (.+) (when struck|on attack|on striking|when you level-up|when you die)/i) {
		my ($level, $spell, $when) = ($1, $2, $3);
		my $type = "?";
		if (lc($when) eq "on striking") { $type = "O"; };
		if (lc($when) eq "when struck") { $type = "W"; };
		if (lc($when) eq "on attack") { $type = "A"; };
		if (lc($when) eq "when you level-up") { $type = "L"; };
		if (lc($when) eq "when you die") { $type = "L"; };
		$getspell_sth->execute($spell) or die;
		my ($spellid) = $getspell_sth->fetchrow_array();
		if (not defined $spellid) {
			$addspell_sth->execute($spell) or die;
			$getspell_sth->execute($spell) or die;
			($spellid) = $getspell_sth->fetchrow_array() or die;
		}

		$getitemprop_sth->execute($propid) or die;
		while (my ($itemid, $val, $val_min, $val_max) = $getitemprop_sth->fetchrow_array()) {

			$addspellprop_sth->execute($itemid,$spellid,$type,$level,undef,undef,$val,$val_min,$val_max,undef) or die;
		}

		$zapip_sth->execute($propid) or warn;
		$zapp_sth->execute($propid) or warn;
		next;
	}
	if ($name =~ /^Charges: (.+) \(Level (\d+)\)$/i) {
		my ($spell, $level) = ($1, $2);
		$getspell_sth->execute($spell) or die;
		my ($spellid) = $getspell_sth->fetchrow_array();
		if (not defined $spellid) {
			$addspell_sth->execute($spell) or die;
			$getspell_sth->execute($spell) or die;
			($spellid) = $getspell_sth->fetchrow_array() or die;
		}

		$getitemprop_sth->execute($propid) or die;
		while (my ($itemid, $val, $val_min, $val_max) = $getitemprop_sth->fetchrow_array()) {

			$addspellprop_sth->execute($itemid,$spellid,"C",$level,undef,undef,undef,undef,undef,$val);
		}
		$zapip_sth->execute($propid) or warn;
		$zapp_sth->execute($propid) or warn;
		next;
	}
}

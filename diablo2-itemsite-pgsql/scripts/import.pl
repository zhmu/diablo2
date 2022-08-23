#!/usr/bin/perl -w

use DBI;
use XML::LibXML;
use strict;

require "config.pl";

sub getType {
	my ($name) = @_;
	our ($sth_gettype);
	our %typeCache;

	return $typeCache{$name} if $typeCache{$name};
	$sth_gettype->execute($name) or die;
	($typeCache{$name}) = $sth_gettype->fetchrow_array();
	return $typeCache{$name} if $typeCache{$name};

	die "Type '$name' nonexistant";
}

sub getProperty {
	my ($name) = @_;
	our ($sth_getprop, $sth_addprop);
	our %propCache;

	return $propCache{lc($name)} if $propCache{lc($name)};
	$sth_getprop->execute($name) or die;
	($propCache{lc($name)}) = $sth_getprop->fetchrow_array();
	return $propCache{lc($name)} if $propCache{lc($name)};

	$sth_addprop->execute($name) or die;
	$sth_getprop->execute($name) or die;
	($propCache{lc($name)}) = $sth_getprop->fetchrow_array();
	return $propCache{lc($name)};
}

sub getSet {
	my ($name) = @_;
	our ($sth_getset, $sth_addset);
	our %setCache;

	return $setCache{$name} if $setCache{$name};
	$sth_getset->execute($name) or die;
	($setCache{$name}) = $sth_getset->fetchrow_array();
	return $setCache{$name} if $setCache{$name};

	$sth_addset->execute($name) or die;
	$sth_getset->execute($name) or die;
	($setCache{$name}) = $sth_getset->fetchrow_array();
	return $setCache{$name};
}

sub bindProperty {
	my ($itemid, $propname, $val, $min, $max, $lev, $force) = @_;
	our $sth_bindprop;

	return if not $val and not $min and not $max and not $lev and not $force;

	my $propid = &getProperty($propname);
	$sth_bindprop->execute($itemid, $propid, $val, $min, $max, $lev) or die "[$propname]";
}

our ($DB_DSN, $DB_USER, $DB_PASS);
my ($fname) = @ARGV;
die "Usage: ./import foo.xml" unless $fname;
print "IMPORTING $fname\n";
my $DB = DBI->connect($DB_DSN, $DB_USER, $DB_PASS) or die;

my $doc = XML::LibXML->new();
my $tree = $doc->parse_file($fname);
my $root = $tree->getDocumentElement;

if (0) {
	$DB->do('DELETE FROM item_item_prop');
	$DB->do('DELETE FROM item');
	$DB->do('DELETE FROM itemset');
}

our %typeCache = ( );
our $sth_gettype = $DB->prepare("SELECT itemtypeid FROM itemtype WHERE name=?");

my $sth_additem = $DB->prepare("INSERT INTO item (name,itemtypeid,itemsetid,sockets,req_level,req_str,req_dex,version) VALUES (?,?,?,?,?,?,?,?)");
my $sth_getitem  = $DB->prepare("SELECT itemid FROM item WHERE name=? AND version=?");

our %setCache = ( );
our $sth_addset = $DB->prepare("INSERT INTO itemset (name) VALUES (?)");
our $sth_getset = $DB->prepare("SELECT itemsetid FROM itemset WHERE name=?");

our %propCache = ();
our $sth_getprop = $DB->prepare("SELECT itempropid FROM itemproperty WHERE name=?");
our $sth_addprop = $DB->prepare("INSERT INTO itemproperty (name) VALUES (?)");
our $sth_bindprop = $DB->prepare("INSERT INTO item_item_prop (itemid,itempropid,value,value_min,value_max,value_perlevel) VALUES (?,?,?,?,?,?)");

foreach my $entry ($root->getElementsByTagName('item')) {
	my @tmp;
	my $name    = $entry->getAttribute('name');
	my $typeid  = &getType($entry->getAttribute('type'));
	my $version = $entry->getAttribute('version');
	$version=~ s/\.//;

	my ($dur, $level_req, $str_req, $dex_req, $sockets) = undef;
	my ($def_min, $def_max, $set) = undef;
	my ($dmg_h1min, $dmg_h1max, $dmg_h2min, $dmg_h2max) = undef;
	my %speed = ( ); my %block = ( );

	# grab durability, if any
	@tmp = $entry->getElementsByTagName("durability");
	$dur = $tmp[0]->getAttribute('max') if @tmp;
	# requirements
	@tmp = $entry->getElementsByTagName("require");
	$level_req = $tmp[0]->getAttribute('level') if @tmp;
	$str_req = $tmp[0]->getAttribute('strength') if @tmp;
	$dex_req = $tmp[0]->getAttribute('dexterity') if @tmp;
	# sockets
	@tmp = $entry->getElementsByTagName("sockets");
	$sockets = $tmp[0]->getAttribute('amount') if @tmp;
	# defense
	@tmp = $entry->getElementsByTagName("defense");
	$def_min = $tmp[0]->getAttribute('val') if @tmp;
	$def_max = $tmp[0]->getAttribute('val') if @tmp;
	# damage
	@tmp = $entry->getElementsByTagName("damage");
	if (@tmp) {
		$dmg_h1min = $tmp[0]->getAttribute('h1min');
		$dmg_h1max = $tmp[0]->getAttribute('h1max');
		$dmg_h2min = $tmp[0]->getAttribute('h2min');
		$dmg_h2max = $tmp[0]->getAttribute('h2max');
	}
	# set 
	@tmp = $entry->getElementsByTagName("set");
	$set = $tmp[0]->getAttribute('name') if @tmp;
	print ">> Processing '$name'\n";

	my $setid = undef;
	$setid = &getSet($set) if $set;

	# create the type
	$sth_additem->execute($name, $typeid, $setid, $sockets, $level_req, $str_req, $dex_req, $version);
	$sth_getitem->execute($name, $version);
	my ($itemid) = $sth_getitem->fetchrow_array();

	&bindProperty($itemid, "Defense", undef, $def_min, $def_max);
	&bindProperty($itemid, "Durability", $dur, undef, undef);
	&bindProperty($itemid, "One-handed Damage", undef, $dmg_h1min, $dmg_h1max);
	&bindProperty($itemid, "Two-handed Damage", undef, $dmg_h2min, $dmg_h2max);

	foreach my $p($entry->getElementsByTagName('property')) {
		my $name  = $p->getAttribute('name');
		my $min   = $p->getAttribute('min');
		my $max   = $p->getAttribute('max');
		my $val   = $p->getAttribute('val');
		my $level = $p->getAttribute('level_multiplier');
		$val=~ s/^\+// if $val;

		# ugly hacks to keep our XML file human-readable
		if (defined $val and $val =~ /^([-]?\d+)%$/) { $name="% $name"; $val=$1; } 
		if (defined $min and $min=~ /^(\d+)-(\d+)$/) { $min=$1; }
		if (defined $max and $max=~ /^(\d+)-(\d+)$/) { $max=$2; }
		&bindProperty($itemid, $name, $val, $min, $max, $level, 1);
	}
#	foreach (keys %block) { &bindProperty($typeid, "Blocking% " . ucfirst($_), $block{$_}, undef, undef); };
}

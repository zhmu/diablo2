#!/usr/bin/perl -w

use DBI;
use XML::LibXML;
use strict;

sub getCategory {
	my ($name) = @_;
	our ($sth_addcat, $sth_getcat);
	our %catCache;

	return $catCache{$name} if $catCache{$name};
	$sth_getcat->execute($name) or die;
	($catCache{$name}) = $sth_getcat->fetchrow_array();
	return $catCache{$name} if $catCache{$name};

	$sth_addcat->execute($name) or die;
	$sth_getcat->execute($name) or die;
	($catCache{$name}) = $sth_getcat->fetchrow_array();
	return $catCache{$name};
}

sub getProperty {
	my ($name) = @_;
	our ($sth_getprop, $sth_addprop);
	our %propCache;

	return $propCache{$name} if $propCache{$name};
	$sth_getprop->execute($name) or die;
	($propCache{$name}) = $sth_getprop->fetchrow_array();
	return $propCache{$name} if $propCache{$name};

	$sth_addprop->execute($name) or die;
	$sth_getprop->execute($name) or die;
	($propCache{$name}) = $sth_getprop->fetchrow_array();
	return $propCache{$name};
}

sub bindProperty {
	my ($typeid, $propname, $val, $min, $max) = @_;
	our $sth_bindprop;

	return if not $val and not $min and not $max;

	my $propid = &getProperty($propname);
	$sth_bindprop->execute($typeid, $propid, $val, $min, $max) or die "[$propname]";
}

sub resolveSpeed {
	my ($s) = @_;
	return undef unless $s;
	return 0 if $s eq "vs";
	return 1 if $s eq "s";
	return 2 if $s eq "n";
	return 3 if $s eq "f";
	return 4 if $s eq "vf";
	die "Unknown speed [$s]";
}

sub resolveWeight {
	my ($w) = @_;
	return 0 if $w eq "light";
	return 1 if $w eq "medium";
	return 2 if $w eq "heavy";
	die "Unknown weight [$w]";
}

my ($fname) = @ARGV;
die "Usage: ./import foo.xml" unless $fname;
print "IMPORTING $fname\n";
my $DB = DBI->connect('DBI:Pg:dbname=diablo2;host=db0', 'diablo2', 'WEUhfiwuh') or die;

my $doc = XML::LibXML->new();
my $tree = $doc->parse_file($fname);
my $root = $tree->getDocumentElement;

if (0) {
	$DB->do('DELETE FROM item_type_prop');
	$DB->do('DELETE FROM itemproperty');
	$DB->do('DELETE FROM itemtype');
	$DB->do('DELETE FROM itemcategory');
}

our %catCache = ( );
our $sth_addcat = $DB->prepare("INSERT INTO itemcategory (name) VALUES (?)");
our $sth_getcat = $DB->prepare("SELECT itemcatid FROM itemcategory WHERE name=?");

my $sth_addtype = $DB->prepare("INSERT INTO itemtype (name,itemcatid,itemclasscatid,level,tc,sockets,req_level,req_str,req_dex) VALUES (?,?,?,?,?,?,?,?,?)");
my $sth_gettype = $DB->prepare("SELECT itemtypeid FROM itemtype WHERE name=?");

our %propCache = ();
our $sth_getprop = $DB->prepare("SELECT itempropid FROM itemproperty WHERE name=?");
our $sth_addprop = $DB->prepare("INSERT INTO itemproperty (name) VALUES (?)");
our $sth_bindprop = $DB->prepare("INSERT INTO item_type_prop (itemtypeid,itempropid,value,value_min,value_max) VALUES (?,?,?,?,?)");

foreach my $entry ($root->getElementsByTagName('type')) {
	my @tmp;
	my $name  = $entry->getAttribute('name');
	my $cat   = $entry->getAttribute('category');
	my $level = $entry->getAttribute('level');
	my $tc    = $entry->getAttribute('tc');
	$tc = undef if $tc eq "x";

	# resolve the level
	my $ilevel = undef;
	$ilevel = 0 if $level eq "normal";
	$ilevel = 1 if $level eq "exceptional";
	$ilevel = 2 if $level eq "elite";

	# look up or create the category
	my $catid = &getCategory($cat);

	my ($dur, $level_req, $str_req, $dex_req, $sockets, $weight) = undef;
	my ($def_min, $def_max, $range, $class, $kick_min, $kick_max) = undef;
	my ($dmg_h1min, $dmg_h1max, $dmg_h2min, $dmg_h2max, $stack) = undef;
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
	# weight
	@tmp = $entry->getElementsByTagName("weight");
	$weight = &resolveWeight($tmp[0]->getAttribute('type')) if @tmp;
	# defense
	@tmp = $entry->getElementsByTagName("defense");
	$def_min = $tmp[0]->getAttribute('min') if @tmp;
	$def_max = $tmp[0]->getAttribute('max') if @tmp;
	# range
	@tmp = $entry->getElementsByTagName("range");
	$range = $tmp[0]->getAttribute('amount') if @tmp;
	# class
	@tmp = $entry->getElementsByTagName("class");
	$class = &getCategory($tmp[0]->getAttribute('type')) if @tmp;
	# speed
	@tmp = $entry->getElementsByTagName("speed");
	if (@tmp) {
		$speed{amazon} = &resolveSpeed($tmp[0]->getAttribute('ama'));
		$speed{assassin} = &resolveSpeed($tmp[0]->getAttribute('asn'));
		$speed{barbarian} = &resolveSpeed($tmp[0]->getAttribute('bar'));
		$speed{druid} = &resolveSpeed($tmp[0]->getAttribute('dru'));
		$speed{necromancer} = &resolveSpeed($tmp[0]->getAttribute('nec'));
		$speed{paladin} = &resolveSpeed($tmp[0]->getAttribute('pal'));
		$speed{sorceress} =&resolveSpeed($tmp[0]->getAttribute('sor'));
	}
	# damage
	@tmp = $entry->getElementsByTagName("damage");
	if (@tmp) {
		$dmg_h1min = $tmp[0]->getAttribute('h1min');
		$dmg_h1max = $tmp[0]->getAttribute('h1max');
		$dmg_h2min = $tmp[0]->getAttribute('h2min');
		$dmg_h2max = $tmp[0]->getAttribute('h2max');
	}
	# kick damage
	@tmp = $entry->getElementsByTagName("kick_damage");
	$kick_min = $tmp[0]->getAttribute('min') if @tmp;
	$kick_max = $tmp[0]->getAttribute('max') if @tmp;
	# stack size
	@tmp = $entry->getElementsByTagName("stack");
	$stack = $tmp[0]->getAttribute('max') if @tmp;
	# blocking
	@tmp = $entry->getElementsByTagName("block");
	if (@tmp) {
		$block{amazon} = $tmp[0]->getAttribute('ama');
		$block{assassin} = $tmp[0]->getAttribute('asn');
		$block{barbarian} = $tmp[0]->getAttribute('bar');
		$block{druid} = $tmp[0]->getAttribute('dru');
		$block{necromancer} = $tmp[0]->getAttribute('nec');
		$block{paladin} = $tmp[0]->getAttribute('pal');
		$block{sorceress} = $tmp[0]->getAttribute('sor');
	}
	#print ">> Processing '$name'\n";

	# create the type
	$sth_addtype->execute($name, $catid, $class, $ilevel, $tc, $sockets, $level_req, $str_req, $dex_req);
	$sth_gettype->execute($name);
	my ($typeid) = $sth_gettype->fetchrow_array();

	&bindProperty($typeid, "Defense", undef, $def_min, $def_max);
	&bindProperty($typeid, "Durability", $dur, undef, undef);
	&bindProperty($typeid, "Range", $range, undef, undef);
	&bindProperty($typeid, "Kick Damage", undef, $kick_min, $kick_max);
	&bindProperty($typeid, "One-handed Damage", undef, $dmg_h1min, $dmg_h1max);
	&bindProperty($typeid, "Two-handed Damage", undef, $dmg_h2min, $dmg_h2max);
	&bindProperty($typeid, "Stack size", $stack, undef, undef);
	foreach (keys %block) { &bindProperty($typeid, "Blocking% " . ucfirst($_), $block{$_}, undef, undef); };
}

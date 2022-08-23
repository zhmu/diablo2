#!/usr/bin/perl -w

use DBI;
use Data::Dumper;
use strict;

require "config.pl";

our ($DB_DSN, $DB_USER, $DB_PASS);
my $DB = DBI->connect($DB_DSN, $DB_USER, $DB_PASS) or die;

sub doAction {
	my ($a, $b, $type) = @_;
	return ($a * ($b / 100)) if $type eq 0;
	return ($a + $b) if $type eq 1;
	die "Argh!";
}

sub handlePropValMinMax {
	my ($prop, $cacheprop, $pname, $min, $max, $val, $type) = @_;

	return if not $min and not $max and not $val;

	if ($prop->{$pname}{"VAL"}) {
		if ($val) {
			$cacheprop->{$pname} = {
				VAL => &doAction($prop->{$pname}{"VAL"}, $val, $type)
			};
		} else {
			$cacheprop->{$pname} = {
				MIN => &doAction($prop->{$pname}{"MIN"}, $min, $type),
				MAX => &doAction($prop->{$pname}{"MAX"}, $max, $type)
			};
		}
	} elsif ($prop->{$pname}{"MIN"} and $prop->{$pname}{"MAX"}) {
		if ($val) {
			$cacheprop->{$pname} = {
				MIN => &doAction($prop->{$pname}{"MIN"}, $val, $type),
				MAX => &doAction($prop->{$pname}{"MAX"}, $val, $type)
			};
		} else {
			$cacheprop->{$pname} = {
				MIN => &doAction($prop->{$pname}{"MIN"}, $min, $type),
				MAX => &doAction($prop->{$pname}{"MAX"}, $max, $type),
			};	
		}
	}
}

sub handlePropValMax {
	my ($prop, $cacheprop, $pname, $min, $max, $val, $type) = @_;

	return if not $min and not $max and not $val;

	if ($val) {
		$cacheprop->{$pname} = {
			MIN => $prop->{$pname}{"MIN"},
			MAX => &doAction($prop->{$pname}{"MAX"}, $val, $type)
		};
	} else {
		$cacheprop->{$pname} = {
			MIN => $prop->{$pname}{"MIN"},
			MAX => &doAction($prop->{$pname}{"MAX"}, $max, $type)
		};
	}
}

sub handlePropValMin {
	my ($prop, $cacheprop, $pname, $min, $max, $val, $type) = @_;

	return if not $min and not $max and not $val;

	if ($val) {
		$cacheprop->{$pname} = {
			MIN => &doAction($prop->{$pname}{"MIN"}, $val, $type),
			MAX => $prop->{$pname}{"MAX"}
		};
	} else {
		$cacheprop->{$pname} = {
			MIN => &doAction($prop->{$pname}{"MIN"}, $min, $type),
			MAX => $prop->{$pname}{"MAX"}
		};
	}
}

$DB->do("DELETE FROM item_itemprop_cache");

my $item_sth = $DB->prepare("
	SELECT itemid,name,itemtypeid
	FROM item 
");
my $it_prop_sth = $DB->prepare("
	SELECT p.name,ip.value,ip.value_min,ip.value_max
	FROM item_type_prop ip,itemproperty p
	WHERE ip.itemtypeid=? AND ip.itempropid=p.itempropid
");
my $i_prop_sth = $DB->prepare("
	SELECT p.name,ip.value,ip.value_min,ip.value_max
	FROM item_item_prop ip,itemproperty p
	WHERE ip.itemid=? AND ip.itempropid=p.itempropid
	ORDER BY name DESC
");
my $i_propcache_sth = $DB->prepare("
	INSERT INTO item_itemprop_cache (itemid,itempropid,value,value_min,value_max)
	VALUES (?,(SELECT itempropid FROM itemproperty WHERE name=?),?,?,?)
");
$item_sth->execute or die;
while (my ($itemid, $itemname, $itemtypeid) = $item_sth->fetchrow_array()) {
	my %prop = ();
	my %cacheprop = ();
	print "[$itemid:$itemname:$itemtypeid]\n";

	# first of all, grab all itemTYPE-specific 
	$it_prop_sth->execute($itemtypeid) or die;
	while (my ($pname, $val, $min, $max) = $it_prop_sth->fetchrow_array()) {
		$prop{$pname} = { VAL => $val, MIN => $min, MAX => $max };
	}

	# XXX: what about order? first % damage, then + damage?
	$i_prop_sth->execute($itemid) or die;
	while (my ($pname, $val, $min, $max) = $i_prop_sth->fetchrow_array()) {
		if ($pname eq "% Enhanced Damage") {
			# normalize values
			$val += 100 if $val and $val > 0; $min += 100 if $min and $min > 0;
			$max += 100 if $max and $max > 0;
			&handlePropValMinMax(\%prop, \%cacheprop, "One-handed Damage", $min, $max, $val, 0) if $prop{"One-handed Damage"};
			&handlePropValMinMax(\%prop, \%cacheprop, "Two-handed Damage", $min, $max, $val, 0) if $prop{"Two-handed Damage"};
			next;
		}

		if ($pname eq "% Enhanced Defense") {
			#die "huh?" if $cacheprop{"Defense"};
			$val += 100 if $val and $val > 0; $min += 100 if $min and $min > 0;
			$max += 100 if $max and $max > 0;
			&handlePropValMinMax(\%prop, \%cacheprop, "Defense", $min, $max, $val, 0);
		}

		if ($pname eq "Defense") {
			#die "huh?" if $cacheprop{"Defense"};
			&handlePropValMinMax(\%prop, \%cacheprop, "Defense", $min, $max, $val, 1);
		}

		if ($pname eq "Damage") {
			#die "huh?" if $cacheprop{"Damage"};
			&handlePropValMinMax(\%prop, \%cacheprop, "One-handed Damage", $min, $max, $val, 1) if $prop{"One-handed Damage"};
			&handlePropValMinMax(\%prop, \%cacheprop, "Two-handed Damage", $min, $max, $val, 1) if $prop{"Two-handed Damage"};
		}

		if ($pname eq "Maximum Damage") {
			#die "huh?" if $cacheprop{"Defense"};
			&handlePropValMax(\%prop, \%cacheprop, "One-handed Damage", $min, $max, $val, 1) if $prop{"One-handed Damage"};
			&handlePropValMax(\%prop, \%cacheprop, "Two-handed Damage", $min, $max, $val, 1) if $prop{"Two-handed Damage"};
		}

		if ($pname eq "Minimum Damage") {
			#die "huh?" if $cacheprop{"Defense"};
			&handlePropValMin(\%prop, \%cacheprop, "One-handed Damage", $min, $max, $val, 1) if $prop{"One-handed Damage"};
			&handlePropValMin(\%prop, \%cacheprop, "Two-handed Damage", $min, $max, $val, 1) if $prop{"Two-handed Damage"};
		}
	}
	foreach (keys %cacheprop) {
		my ($val, $min, $max) = ($cacheprop{$_}{"VAL"}, $cacheprop{$_}{"MIN"}, $cacheprop{$_}{"MAX"});
		$val = int($val) if $val;
		$min = int($min) if $min;
		$max = int($max) if $max;
		$i_propcache_sth->execute($itemid, $_, $val, $min, $max) or die;
	}
}

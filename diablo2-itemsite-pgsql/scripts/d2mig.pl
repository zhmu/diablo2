#!/usr/bin/perl -w

use DBI;
use strict;

my @attrs = (
	"Prevent Monster Heal", "Freezes Target", "Piercing Attack",
	"Knockback", "Ignore Target's Defense", "Hit Blinds Target",
	"Indestructible", "Cannot Be Frozen", "Fires Explosive Arrows or Bolts",
	"Fires Magic Arrows", "Half Freeze Duration"
);

sub
migrateItems {
	my ($query) = @_;
	our $olddb;

	my $typesth = $olddb->prepare("SELECT name FROM types WHERE id=?");
	my $setsth = $olddb->prepare("SELECT name FROM sets WHERE id=?");
	my $sth = $olddb->prepare($query);
	$sth->execute or die;
	while (my ($name, $desc, $typeid, $setid, $d1h_min, $d1h_max, $d2h_min, $d2h_max, $def, $maxdur, $speed, $req_level, $req_str, $req_dex) = $sth->fetchrow_array()) {
		$typesth->execute($typeid) or die;
		my ($type) = $typesth->fetchrow_array();

		$desc=~ s/\r//g;
		print " <item name=\"$name\" type=\"$type\">\n";
		if ($setid) {
			$setsth->execute($setid) or die;
			my ($set) = $setsth->fetchrow_array();
			print "  <set name=\"$set\" />\n";
		}
		if ($d1h_min or $d1h_max or $d2h_min or $d2h_max) {
			die "foo" if ($d1h_min and not $d1h_max) or ($d1h_max and not $d1h_min);
			die "bar" if ($d2h_min and not $d2h_max) or ($d2h_max and not $d2h_min);
#			print "  <damage";
#			print " h1min=\"$d1h_min\" h1max=\"$d1h_max\"" if $d1h_min and $d1h_max;
#			print " h2min=\"$d2h_min\" h2max=\"$d2h_max\"" if $d2h_min and $d2h_max;
#			print " />\n";
	  }
		if ($req_level or $req_str or $req_dex) {
			print "  <require";
			print " level=\"$req_level\"" if $req_level;
			print " strength=\"$req_str\"" if $req_str;
			print " dexterity=\"$req_dex\"" if $req_dex;
			print " />\n";
		}
		#print "  <durability max=\"$maxdur\" />\n" if $maxdur > 0;
		#print "  <defense val=\"$def\" />\n" if $def > 0;

		foreach (split(/\n/, $desc)) {
			s/^\+ /+/;
			# range of a...b of a single property
			if (/(\d+-\d+?)([%]?) (.+)$/) {
				my ($val, $pct, $prop) = ($1, $2, $3);
				$val =~ /^(\d+)-(\d+)$/; #or die;
				if ($pct ne "") { $prop = "% $prop"; }
				print "  <property name=\"$prop\" min=\"$1\" max=\"$2\" />\n";
				next;
			}
			if (/^(.+) [+]?(\d+-\d+?)[%]?$/) {
				my ($val, $prop) = ($2, $1);
				$val =~ /^(\d+)-(\d+)$/; #or die;
				print "  <property name=\"$prop\" min=\"$1\" max=\"$2\" />\n";
				next;
			}
			if (/^([-+]?\d+[%]?) (.+)$/) {
				my ($pts, $attr) = ($1, $2); $attr=~ s/^to //i;
				print "  <property name=\"$attr\" val=\"$pts\" />\n";
				next;
			}
			if (/^(.+) ([+-]?\d+[%]?)$/) {
				print "  <property name=\"$1\" val=\"$2\" />\n";
				next;
			}
			if (/^Level (\d+) (.+) \((\d+) Charges\)$/) {
				print "  <property name=\"Charges: $2 (Level $1)\" val=\"$3\" />\n";
				next;
			}
			if (/^(.+) \((\d+)\)$/ or /^(.+) \[(\d+)\]$/) {
				if ($1 eq "Socketed") {
					print "  <sockets amount=\"5\" />\n";
				} else {
					print "  <property name=\"$1\" value=\"$2\" />\n";
				}
				next;
			}
			if (/^Repairs (\d+) durability in (\d+) seconds$/i) {
				print "  <property name=\"Repairs $1 durability every N seconds\" value=\"$2\" />\n";
				next;
			}
			if (/^Adds \((\d+-\d+)\) to \((\d+-\d+)\) (.+)$/ or
			    /^Adds \((\d+-\d+)\)-\((\d+-\d+)\) (.+)$/ or
			    /^Adds (\d+)-\((\d+-\d+)\) (.+)$/) {
				print "  <property name=\"$3\" min=\"$1\" max=\"$2\" />\n";
				next;
			}
			if (/^\+\(([\d.]+) Per Charac[h]?ter Level\) [\d.]+-[\d.]+ (.+)$/i or
			  /^\+\(([\d.]+) Per Charac[h]?ter Level\) (.+)$/i) {
				my ($a,$b)=($1,$2);$b=~ s/to\s+//;
				print "  <property name=\"$b\" level_multiplier=\"$a\" />\n";
				next;
			}
			my $a = $_;
			if (grep { lc($a) eq lc($_) } @attrs) {
				print "  <property name=\"$_\" />\n";
				next;
			}
			die "FIXME: [$_]";
		}

		print " </item>\n";
		print "\n";
	}
}

our $olddb = DBI->connect($OLDDB_DSN, $OLDDB_USER, $OLDDB_PASS) or die;
print "<items>\n";
&migrateItems("SELECT name,description,type,NULL,ohdamage_min,ohdamage_max,thdamage_min,thdamage_max,defense,max_durability,speed,req_level,req_strength,req_dex FROM unique_items");
&migrateItems("SELECT name,description,type,set_id,ohdamage_min,ohdamage_max,thdamage_min,thdamage_max,defense,max_durability,speed,req_level,req_strength,req_dex FROM set_items");
print "</items>\n";

#my $sth = $olddb->prepare("SELECT name,description FROM unique_items");

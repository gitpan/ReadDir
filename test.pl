# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

#use Test::More tests => 8;

use Test;

BEGIN {
    plan tests => 8
};
use ReadDir qw(&readdir_inode &readdir_arrayref &readdir_hashref);

ok(1);

my @ents = readdir_inode("cheese");

is(2, scalar @ents, 0, "readdir_inode on a non-existant directory");
like(3, $!, qr/no such file|not found/i,
     "readdir_inode on a non-existant directory (perror)");

my @ents = readdir_inode(".");

is(4, ref $ents[0], "ARRAY",
   "readdir_inode returns list of array refs");

my ($filename, $inode) = @{$ents[0]};

is(5, $inode, ((stat $filename)[1]),
   "readdir_inode returns inode numbers");

my $ents_a = readdir_arrayref(".");
is(6, ref $ents_a->[0], "ARRAY",
   "readdir_arrayref returns an arrayref of arrays");

is(7, $ents_a->[0]->[1], $ents[0]->[1],
   "readdir_arrayref agrees with readdir_inode");

$ents_h = readdir_hashref(".");
$should_be_h = { map { ($_->[0] => $_->[1]) } @ents };

ish(8, $ents_h, $should_be_h,
    "readdir_hashref agrees with readdir_inode");

# use Data::Dumper;
# print Dumper $ents_h;

sub is {
    my ($num, $a, $b, $what) = (@_);

    if ($a ne $b) {
	ok(0);
    } else {
	ok(1);
    }
}

sub like {
    my ($num, $string, $pattern, $what) = (@_);

    if ($string =~ m/$pattern/) {
	ok(1);
    } else {
	ok(0);
    }
}

sub ish {
    my ($num, $a, $b, $what) = (@_);

    if ( ref $a ne "HASH" or ref $b ne "HASH" ) {
	ok(0);
    } else {

	my %c = ( map { $_ => 1 } keys %$b );

	$ok = 1;
	while ( my ($k, $v) = each (%$a) ) {
	    if ( !exists $b->{$k} or $b->{$k} != $v) {
		$ok = 0;
		last;
	    } else {
		delete $c{$k};
	    }
	}

	if ( keys %c ) {
	    $ok = 0;
	}

	ok($ok);
    }
}

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

#use Test::More tests => 8;

use Test;

BEGIN {
    plan tests => 5
};
use ReadDir qw(&readdir_inode);

ok(1);

my @ents = readdir_inode("cheese");

is(2, scalar @ents, 0, "readdir on a non-existant directory");
like(3, $!, qr/no such file|not found/i, "readdir on a non-existant directory (perror)");

my @ents = readdir_inode(".");

is(4, ref $ents[0], "ARRAY", "readdir returns list of array refs");

my ($filename, $inode) = @{$ents[0]};

is(5, $inode, ((stat $filename)[1]), "readdir returns inode numbers");

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

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

#!/usr/bin/perl -w

package ReadDir;

use 5.005;
use strict;

require Exporter;
require DynaLoader;

BEGIN {
    use vars qw(@ISA %EXPORT_TAGS @EXPORT_OK $VERSION);

    @ISA = qw(Exporter DynaLoader);

    %EXPORT_TAGS = ( 'all' => [ qw( &readdir_inode ) ] );

    @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

    $VERSION = '0.01';
};

bootstrap ReadDir $VERSION;

1;
__END__

=head1 NAME

ReadDir - Get the inode numbers in your readdir call.

=head1 SYNOPSIS

  use ReadDir qw(&readdir_inode);

  my (@files) = readdir_inode ".";

  printf ("%7d %s\n", $_->[1], $_->[0])
      foreach (@files);

=head1 DESCRIPTION

readdir_inode is a lot like the builtin readdir, but this function
returns the inode numbers of the directory entries as well.

So, the example in the synopsis is a quick `C<ls -i>'.

This will save you a `stat' in certain situations.  I didn't implement
the whole opendir/readdir/closedir stuff, because that's a bunch of
arse.

=head2 CAVEATS

If the directory entry in question is a mount point, you will receive
the inode number of the B<underlying directory>, not the root inode of
the mounted filesystem.

This may not be a very portable function, either.  It works on Linux
and Solaris, at least.

=head1 AUTHOR

Sam Vilain, E<lt>sam@vilain.netE<gt>

=head1 SEE ALSO

L<perlfunc>.

=cut

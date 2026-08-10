#!/usr/bin/env perl
# Sort a fixed list with a quicksort over the head and tail of the argument list.

use strict;
use warnings;

sub quicksort {
    return @_ if @_ <= 1;

    my ( $pivot, @rest ) = @_;
    my @smaller = grep { $_ <= $pivot } @rest;
    my @larger  = grep { $_ > $pivot } @rest;
    return ( quicksort(@smaller), $pivot, quicksort(@larger) );
}

print join( ' ', quicksort( 5, 3, 8, 4, 2, 7, 1, 10, 9, 6 ) ), "\n";

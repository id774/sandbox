#!/usr/bin/env perl
# quicksort.pl: Quicksort of a fixed integer sequence
#
# Description:
# Sort a fixed list with a quicksort over the head and tail of the argument list.
#
# Part of the basics cross-language exercise set: the input is fixed in the
# source, and the output is the same as that of the same exercise in every
# other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     perl quicksort.pl
#
# Requirements:
# - Perl 5.10 or later
# - No third-party package is required

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

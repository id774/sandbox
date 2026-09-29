#!/usr/bin/env perl
# fibonacci.pl: The first 20 Fibonacci numbers
#
# Description:
# Print the first 20 Fibonacci numbers, carried in a pair of scalars.
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
#     perl fibonacci.pl
#
# Requirements:
# - Perl 5.10 or later
# - No third-party package is required

use strict;
use warnings;

my ( $current, $next ) = ( 0, 1 );
my @values;

for ( 1 .. 20 ) {
    push @values, $current;
    ( $current, $next ) = ( $next, $current + $next );
}

print join( ' ', @values ), "\n";

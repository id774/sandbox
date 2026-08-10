#!/usr/bin/env perl
# Print the first 20 Fibonacci numbers, carried in a pair of scalars.

use strict;
use warnings;

my ( $current, $next ) = ( 0, 1 );
my @values;

for ( 1 .. 20 ) {
    push @values, $current;
    ( $current, $next ) = ( $next, $current + $next );
}

print join( ' ', @values ), "\n";

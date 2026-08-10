#!/usr/bin/env perl
# Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a list assignment.

use strict;
use warnings;

my @pairs = ([1071, 462], [270, 192], [17, 5], [120, 36]);

sub gcd {
    my ($first, $second) = @_;
    ($first, $second) = ($second, $first % $second) while $second;
    return $first;
}

for my $pair (@pairs) {
    my ($first, $second) = @$pair;
    my $divisor = gcd($first, $second);
    printf "%d %d %d %d\n", $first, $second, $divisor, $first / $divisor * $second;
}

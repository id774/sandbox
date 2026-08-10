#!/usr/bin/env perl
# Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.

use strict;
use warnings;

my $limit = 1000;

sub chain_length {
    my ($start) = @_;
    my $length = 1;
    while ($start != 1) {
        $start = $start % 2 == 0 ? $start / 2 : $start * 3 + 1;
        $length++;
    }
    return $length;
}

my ($longest, $best) = (1, 1);
for my $start (1 .. $limit - 1) {
    my $length = chain_length($start);
    ($longest, $best) = ($start, $length) if $length > $best;
}

print "$longest $best\n";

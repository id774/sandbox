#!/usr/bin/env perl
# Print the primes below 100, sieved over an array of flags indexed by the number itself.

use strict;
use warnings;

my $limit = 100;
my @is_prime = (1) x $limit;
@is_prime[0, 1] = (0, 0);

for my $n (2 .. int sqrt $limit) {
    next unless $is_prime[$n];
    for (my $multiple = $n * $n; $multiple < $limit; $multiple += $n) {
        $is_prime[$multiple] = 0;
    }
}

print join(' ', grep { $is_prime[$_] } 0 .. $limit - 1), "\n";

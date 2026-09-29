#!/usr/bin/env perl
# sieve.pl: Primes below 100 by the sieve of Eratosthenes
#
# Description:
# Print the primes below 100, sieved over an array of flags indexed by the number itself.
#
# Part of the math cross-language exercise set: it reads no arguments or
# standard input, keeps its data fixed in the source, uses integer
# arithmetic only, and its output is the same as that of the same exercise
# in every other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     perl sieve.pl
#
# Requirements:
# - Perl 5.10 or later
# - No third-party package is required

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

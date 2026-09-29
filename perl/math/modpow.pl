#!/usr/bin/env perl
# modpow.pl: Modular exponentiation of fixed triples by repeated squaring
#
# Description:
# Print modular powers of fixed triples, each squared and halved by repeated squaring.
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
#     perl modpow.pl
#
# Requirements:
# - Perl 5.10 or later
# - No third-party package is required

use strict;
use warnings;

my @cases = ([2, 1000, 1000003], [3, 200, 50], [5, 117, 19], [10, 18, 9999991]);

sub modpow {
    my ($base, $exponent, $modulus) = @_;
    my $result = 1;
    $base %= $modulus;
    while ($exponent) {
        $result = $result * $base % $modulus if $exponent % 2;
        $base = $base * $base % $modulus;
        $exponent = int($exponent / 2);
    }
    return $result;
}

for my $case (@cases) {
    my ($base, $exponent, $modulus) = @$case;
    printf "%d %d %d %d\n", $base, $exponent, $modulus, modpow($base, $exponent, $modulus);
}

#!/usr/bin/env perl
# Print modular powers of fixed triples, each squared and halved by repeated squaring.

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

#!/usr/bin/env perl
# Multiply two fixed 3x3 integer matrices held as references to arrays of references.

use strict;
use warnings;

my $left  = [[2, -1, 0], [1, 3, 4], [0, 5, -2]];
my $right = [[1, 0, 2], [-3, 1, 1], [4, 2, 0]];

sub multiply {
    my ($a, $b) = @_;
    my @product;
    for my $i (0 .. 2) {
        for my $j (0 .. 2) {
            $product[$i][$j] += $a->[$i][$_] * $b->[$_][$j] for 0 .. 2;
        }
    }
    return \@product;
}

sub determinant {
    my ($m) = @_;
    return $m->[0][0] * ($m->[1][1] * $m->[2][2] - $m->[1][2] * $m->[2][1])
         - $m->[0][1] * ($m->[1][0] * $m->[2][2] - $m->[1][2] * $m->[2][0])
         + $m->[0][2] * ($m->[1][0] * $m->[2][1] - $m->[1][1] * $m->[2][0]);
}

my $product = multiply($left, $right);

print join(' ', @$_), "\n" for @$product;
print determinant($product), "\n";

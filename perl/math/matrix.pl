#!/usr/bin/env perl
# matrix.pl: Product and determinant of two fixed 3x3 integer matrices
#
# Description:
# Multiply two fixed 3x3 integer matrices held as references to arrays of references.
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
#     perl matrix.pl
#
# Requirements:
# - Perl 5.10 or later
# - No third-party package is required

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

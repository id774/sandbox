#!/usr/bin/env perl
# Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.

use strict;
use warnings;

my $rows = 10;
my @row  = (1);

for (1 .. $rows) {
    print join(' ', @row), "\n";
    my @shifted = (0, @row);
    my @padded  = (@row, 0);
    @row = map { $shifted[$_] + $padded[$_] } 0 .. $#shifted;
}

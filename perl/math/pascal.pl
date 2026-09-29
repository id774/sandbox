#!/usr/bin/env perl
# pascal.pl: The first 10 rows of Pascal's triangle
#
# Description:
# Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
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
#     perl pascal.pl
#
# Requirements:
# - Perl 5.10 or later
# - No third-party package is required

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

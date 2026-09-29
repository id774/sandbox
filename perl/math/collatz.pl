#!/usr/bin/env perl
# collatz.pl: Longest Collatz sequence for a start below 1000
#
# Description:
# Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
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
#     perl collatz.pl
#
# Requirements:
# - Perl 5.10 or later
# - No third-party package is required

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

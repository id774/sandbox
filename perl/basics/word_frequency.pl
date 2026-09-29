#!/usr/bin/env perl
# word_frequency.pl: Word frequencies of a fixed sentence
#
# Description:
# Count the words of a fixed text, most frequent first and alphabetically within a tie.
#
# Part of the basics cross-language exercise set: the input is fixed in the
# source, and the output is the same as that of the same exercise in every
# other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     perl word_frequency.pl
#
# Requirements:
# - Perl 5.10 or later
# - No third-party package is required

use strict;
use warnings;

my $text = 'the quick brown fox jumps over the lazy dog the fox barks';

my %counts;
$counts{$_}++ for split /\s+/, $text;

for my $word ( sort { $counts{$b} <=> $counts{$a} or $a cmp $b } keys %counts ) {
    print "$word $counts{$word}\n";
}

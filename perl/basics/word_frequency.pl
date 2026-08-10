#!/usr/bin/env perl
# Count the words of a fixed text, most frequent first and alphabetically within a tie.

use strict;
use warnings;

my $text = 'the quick brown fox jumps over the lazy dog the fox barks';

my %counts;
$counts{$_}++ for split /\s+/, $text;

for my $word ( sort { $counts{$b} <=> $counts{$a} or $a cmp $b } keys %counts ) {
    print "$word $counts{$word}\n";
}

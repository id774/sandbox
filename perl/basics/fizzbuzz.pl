#!/usr/bin/env perl
# fizzbuzz.pl: FizzBuzz for 1 through 100
#
# Description:
# Print FizzBuzz for 1 through 100, choosing the label from the remainders.
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
#     perl fizzbuzz.pl
#
# Requirements:
# - Perl 5.10 or later
# - No third-party package is required

use strict;
use warnings;

sub label {
    my ($n) = @_;
    return 'FizzBuzz' if $n % 15 == 0;
    return 'Fizz'     if $n % 3 == 0;
    return 'Buzz'     if $n % 5 == 0;
    return $n;
}

print label($_), "\n" for 1 .. 100;

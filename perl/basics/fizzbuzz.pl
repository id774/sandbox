#!/usr/bin/env perl
# Print FizzBuzz for 1 through 100, choosing the label from the remainders.

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

#!/bin/sh
# modpow.sh: Modular exponentiation of fixed triples by repeated squaring
#
# Description:
# Print modular powers of fixed triples, each squared and halved by repeated squaring.
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
#     sh modpow.sh
#
# Requirements:
# - A POSIX.1-2008 sh, such as dash 0.5 or later
# - No third-party package is required

modpow() {
    base=$(($1 % $3))
    exponent=$2
    modulus=$3

    result=1
    while [ "$exponent" -gt 0 ]; do
        if [ $((exponent % 2)) -eq 1 ]; then
            result=$((result * base % modulus))
        fi
        base=$((base * base % modulus))
        exponent=$((exponent / 2))
    done
    echo "$result"
}

for case in 2:1000:1000003 3:200:50 5:117:19 10:18:9999991; do
    base=${case%%:*}
    rest=${case#*:}
    exponent=${rest%:*}
    modulus=${rest#*:}
    echo "$base $exponent $modulus $(modpow "$base" "$exponent" "$modulus")"
done

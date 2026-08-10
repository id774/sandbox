#!/bin/sh
# Print modular powers of fixed triples, each squared and halved by repeated squaring.

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

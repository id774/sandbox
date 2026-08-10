#!/bin/bash
# Print modular powers of fixed triples, each squared and halved by repeated squaring.

cases=("2 1000 1000003" "3 200 50" "5 117 19" "10 18 9999991")

modpow() {
    local base=$(($1 % $3)) exponent=$2 modulus=$3 result=1
    while ((exponent > 0)); do
        ((exponent % 2 == 1)) && ((result = result * base % modulus))
        ((base = base * base % modulus))
        ((exponent /= 2))
    done
    printf '%s\n' "$result"
}

for case in "${cases[@]}"; do
    read -r base exponent modulus <<<"$case"
    printf '%d %d %d %d\n' "$base" "$exponent" "$modulus" "$(modpow "$base" "$exponent" "$modulus")"
done

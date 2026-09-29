(*
 * modpow.ml: Modular exponentiation of fixed triples by repeated squaring
 *
 * Description:
 * Print modular powers of fixed triples, each squared and halved by repeated squaring.
 *
 * Part of the math cross-language exercise set: it reads no arguments or
 * standard input, keeps its data fixed in the source, uses integer
 * arithmetic only, and its output is the same as that of the same exercise
 * in every other language. The exercises are specified in README.md at the
 * repository root.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Usage:
 *     ocaml modpow.ml
 *
 * Requirements:
 * - OCaml 4.08 or later (the ocaml toplevel)
 * - No third-party package is required
 *)

let cases = [ (2, 1000, 1000003); (3, 200, 50); (5, 117, 19); (10, 18, 9999991) ]

let modpow base exponent modulus =
  let rec walk base exponent result =
    if exponent = 0 then result
    else
      let result = if exponent mod 2 = 1 then result * base mod modulus else result in
      walk (base * base mod modulus) (exponent / 2) result
  in
  walk (base mod modulus) exponent 1

let () =
  List.iter
    (fun (base, exponent, modulus) ->
      Printf.printf "%d %d %d %d\n" base exponent modulus (modpow base exponent modulus))
    cases

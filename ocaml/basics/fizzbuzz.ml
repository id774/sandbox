(*
 * fizzbuzz.ml: FizzBuzz for 1 through 100
 *
 * Description:
 * Print FizzBuzz for 1 through 100, choosing the label by matching a pair of remainders.
 *
 * Part of the basics cross-language exercise set: the input is fixed in the
 * source, and the output is the same as that of the same exercise in every
 * other language. The exercises are specified in README.md at the
 * repository root.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Usage:
 *     ocaml fizzbuzz.ml
 *
 * Requirements:
 * - OCaml 4.08 or later (the ocaml toplevel)
 * - No third-party package is required
 *)

let label n =
  match (n mod 3, n mod 5) with
  | 0, 0 -> "FizzBuzz"
  | 0, _ -> "Fizz"
  | _, 0 -> "Buzz"
  | _ -> string_of_int n

let () =
  for n = 1 to 100 do
    print_endline (label n)
  done

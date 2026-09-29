(*
 * sieve.ml: Primes below 100 by the sieve of Eratosthenes
 *
 * Description:
 * Print the primes below 100, sieved by filtering each prime's multiples out of the candidates.
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
 *     ocaml sieve.ml
 *
 * Requirements:
 * - OCaml 4.08 or later (the ocaml toplevel)
 * - No third-party package is required
 *)

let rec sieve = function
  | [] -> []
  | prime :: rest -> prime :: sieve (List.filter (fun n -> n mod prime <> 0) rest)

let () =
  List.init 98 (fun i -> i + 2)
  |> sieve
  |> List.map string_of_int
  |> String.concat " "
  |> print_endline

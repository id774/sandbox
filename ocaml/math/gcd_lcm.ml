(*
 * gcd_lcm.ml: GCD and LCM of fixed pairs by Euclid's algorithm
 *
 * Description:
 * Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a recursion.
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
 *     ocaml gcd_lcm.ml
 *
 * Requirements:
 * - OCaml 4.08 or later (the ocaml toplevel)
 * - No third-party package is required
 *)

let pairs = [ (1071, 462); (270, 192); (17, 5); (120, 36) ]

let rec euclid first second = if second = 0 then first else euclid second (first mod second)

let () =
  List.iter
    (fun (first, second) ->
      let divisor = euclid first second in
      Printf.printf "%d %d %d %d\n" first second divisor (first / divisor * second))
    pairs

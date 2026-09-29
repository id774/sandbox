(*
 * fibonacci.ml: The first 20 Fibonacci numbers
 *
 * Description:
 * Print the first 20 Fibonacci numbers, accumulated by a tail-recursive loop.
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
 *     ocaml fibonacci.ml
 *
 * Requirements:
 * - OCaml 4.08 or later (the ocaml toplevel)
 * - No third-party package is required
 *)

let fibonacci count =
  let rec loop i current next acc =
    if i = count then List.rev acc
    else loop (i + 1) next (current + next) (current :: acc)
  in
  loop 0 0 1 []

let () =
  fibonacci 20 |> List.map string_of_int |> String.concat " " |> print_endline

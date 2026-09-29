(*
 * pascal.ml: The first 10 rows of Pascal's triangle
 *
 * Description:
 * Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
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
 *     ocaml pascal.ml
 *
 * Requirements:
 * - OCaml 4.08 or later (the ocaml toplevel)
 * - No third-party package is required
 *)

let rows = 10

let next row = List.map2 ( + ) (0 :: row) (row @ [ 0 ])

let () =
  let row = ref [ 1 ] in
  for _ = 1 to rows do
    !row |> List.map string_of_int |> String.concat " " |> print_endline;
    row := next !row
  done

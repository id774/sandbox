(*
 * quicksort.ml: Quicksort of a fixed integer sequence
 *
 * Description:
 * Sort a fixed list with a quicksort matching on the head and tail of the list.
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
 *     ocaml quicksort.ml
 *
 * Requirements:
 * - OCaml 4.08 or later (the ocaml toplevel)
 * - No third-party package is required
 *)

let rec quicksort = function
  | [] -> []
  | pivot :: rest ->
      let smaller = List.filter (fun x -> x <= pivot) rest in
      let larger = List.filter (fun x -> x > pivot) rest in
      quicksort smaller @ [ pivot ] @ quicksort larger

let () =
  [ 5; 3; 8; 4; 2; 7; 1; 10; 9; 6 ]
  |> quicksort
  |> List.map string_of_int
  |> String.concat " "
  |> print_endline

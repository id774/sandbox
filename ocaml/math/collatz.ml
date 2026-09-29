(*
 * collatz.ml: Longest Collatz sequence for a start below 1000
 *
 * Description:
 * Print the start below 1000 with the longest Collatz sequence, tracked in a fold over the range.
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
 *     ocaml collatz.ml
 *
 * Requirements:
 * - OCaml 4.08 or later (the ocaml toplevel)
 * - No third-party package is required
 *)

let limit = 1000

let chain_length start =
  let rec walk value length =
    if value = 1 then length
    else
      let next = if value mod 2 = 0 then value / 2 else (value * 3) + 1 in
      walk next (length + 1)
  in
  walk start 1

let () =
  let longest, best =
    List.fold_left
      (fun (longest, best) start ->
        let length = chain_length start in
        if length > best then (start, length) else (longest, best))
      (1, 1)
      (List.init (limit - 1) (fun i -> i + 1))
  in
  Printf.printf "%d %d\n" longest best

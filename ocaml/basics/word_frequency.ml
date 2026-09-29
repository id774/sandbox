(*
 * word_frequency.ml: Word frequencies of a fixed sentence
 *
 * Description:
 * Count the words of a fixed text, most frequent first and alphabetically within a tie.
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
 *     ocaml word_frequency.ml
 *
 * Requirements:
 * - OCaml 4.08 or later (the ocaml toplevel)
 * - No third-party package is required
 *)

module StringMap = Map.Make (String)

let text = "the quick brown fox jumps over the lazy dog the fox barks"

let () =
  let words = String.split_on_char ' ' text |> List.filter (fun word -> word <> "") in
  let counts =
    List.fold_left
      (fun acc word ->
        let current = Option.value (StringMap.find_opt word acc) ~default:0 in
        StringMap.add word (current + 1) acc)
      StringMap.empty words
  in
  StringMap.bindings counts
  |> List.sort (fun (word_a, count_a) (word_b, count_b) ->
         if count_a <> count_b then compare count_b count_a
         else compare word_a word_b)
  |> List.iter (fun (word, count) -> Printf.printf "%s %d\n" word count)

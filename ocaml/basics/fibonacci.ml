(* Print the first 20 Fibonacci numbers, accumulated by a tail-recursive loop. *)
(* Run: ocaml fibonacci.ml *)

let fibonacci count =
  let rec loop i current next acc =
    if i = count then List.rev acc
    else loop (i + 1) next (current + next) (current :: acc)
  in
  loop 0 0 1 []

let () =
  fibonacci 20 |> List.map string_of_int |> String.concat " " |> print_endline

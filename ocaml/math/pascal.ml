(* Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways. *)
(* Run: ocaml pascal.ml *)

let rows = 10

let next row = List.map2 ( + ) (0 :: row) (row @ [ 0 ])

let () =
  let row = ref [ 1 ] in
  for _ = 1 to rows do
    !row |> List.map string_of_int |> String.concat " " |> print_endline;
    row := next !row
  done

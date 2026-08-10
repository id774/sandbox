(* Sort a fixed list with a quicksort matching on the head and tail of the list. *)
(* Run: ocaml quicksort.ml *)

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

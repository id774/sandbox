(* Multiply two fixed 3x3 integer matrices held as arrays of arrays. *)
(* Run: ocaml matrix.ml *)

let size = 3
let left = [| [| 2; -1; 0 |]; [| 1; 3; 4 |]; [| 0; 5; -2 |] |]
let right = [| [| 1; 0; 2 |]; [| -3; 1; 1 |]; [| 4; 2; 0 |] |]

let multiply a b =
  Array.init size (fun i ->
      Array.init size (fun j ->
          let sum = ref 0 in
          for k = 0 to size - 1 do
            sum := !sum + (a.(i).(k) * b.(k).(j))
          done;
          !sum))

let determinant m =
  (m.(0).(0) * ((m.(1).(1) * m.(2).(2)) - (m.(1).(2) * m.(2).(1))))
  - (m.(0).(1) * ((m.(1).(0) * m.(2).(2)) - (m.(1).(2) * m.(2).(0))))
  + (m.(0).(2) * ((m.(1).(0) * m.(2).(1)) - (m.(1).(1) * m.(2).(0))))

let () =
  let product = multiply left right in
  Array.iter
    (fun row -> row |> Array.to_list |> List.map string_of_int |> String.concat " " |> print_endline)
    product;
  print_endline (string_of_int (determinant product))

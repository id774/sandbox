(* Print the primes below 100, sieved by filtering each prime's multiples out of the candidates. *)
(* Run: ocaml sieve.ml *)

let rec sieve = function
  | [] -> []
  | prime :: rest -> prime :: sieve (List.filter (fun n -> n mod prime <> 0) rest)

let () =
  List.init 98 (fun i -> i + 2)
  |> sieve
  |> List.map string_of_int
  |> String.concat " "
  |> print_endline

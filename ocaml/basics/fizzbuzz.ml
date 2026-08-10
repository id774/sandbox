(* Print FizzBuzz for 1 through 100, choosing the label by matching a pair of remainders. *)
(* Run: ocaml fizzbuzz.ml *)

let label n =
  match (n mod 3, n mod 5) with
  | 0, 0 -> "FizzBuzz"
  | 0, _ -> "Fizz"
  | _, 0 -> "Buzz"
  | _ -> string_of_int n

let () =
  for n = 1 to 100 do
    print_endline (label n)
  done

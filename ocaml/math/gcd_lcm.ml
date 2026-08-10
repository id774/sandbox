(* Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a recursion. *)
(* Run: ocaml gcd_lcm.ml *)

let pairs = [ (1071, 462); (270, 192); (17, 5); (120, 36) ]

let rec euclid first second = if second = 0 then first else euclid second (first mod second)

let () =
  List.iter
    (fun (first, second) ->
      let divisor = euclid first second in
      Printf.printf "%d %d %d %d\n" first second divisor (first / divisor * second))
    pairs

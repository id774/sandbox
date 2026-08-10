(* Print modular powers of fixed triples, each squared and halved by repeated squaring. *)
(* Run: ocaml modpow.ml *)

let cases = [ (2, 1000, 1000003); (3, 200, 50); (5, 117, 19); (10, 18, 9999991) ]

let modpow base exponent modulus =
  let rec walk base exponent result =
    if exponent = 0 then result
    else
      let result = if exponent mod 2 = 1 then result * base mod modulus else result in
      walk (base * base mod modulus) (exponent / 2) result
  in
  walk (base mod modulus) exponent 1

let () =
  List.iter
    (fun (base, exponent, modulus) ->
      Printf.printf "%d %d %d %d\n" base exponent modulus (modpow base exponent modulus))
    cases

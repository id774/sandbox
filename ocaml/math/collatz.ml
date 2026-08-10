(* Print the start below 1000 with the longest Collatz sequence, tracked in a fold over the range. *)
(* Run: ocaml collatz.ml *)

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

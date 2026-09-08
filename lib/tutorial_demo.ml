open Option

(** Lists in OCaml *)
type 'a rlist = Rnil | Rcons of 'a * 'a rlist

let example_list = Rcons (5, Rcons (6, Rnil))
let example_list' = Rcons ("Hello", Rcons ("World", Rnil))

(** Append/concatenate two lists. *)
let rec append (l1 : 'a rlist) (l2 : 'a rlist) : 'a rlist =
  match l1 with Rnil -> l2 | Rcons (x, l1) -> Rcons (x, append l1 l2)

(** Transform a list [l : 'a list] into a new list [rmap f l : 'b list] by
    transforming every element in [l] with [f : 'a -> 'b]. *)
let rec rmap (f : 'a -> 'b) (l : 'a rlist) : 'b rlist =
  match l with Rnil -> Rnil | Rcons (x, l) -> Rcons (f x, rmap f l)

(* The "arithmetic" language. *)
type arith =
  | Int of int
  | Add of arith * arith
  | Sub of arith * arith
  | Neg of arith
  | Div of arith * arith

(* 1 + 2 ~> 3 *)
let arith1 = Add (Int 1, Int 2)

(* 3 - 5/7 ~> 3 *)
let arith2 = Sub (Int 3, Div (Int 5, Int 7))

(** Evaluation of arithmetic expression [a] *)
let rec eval (a : arith) : int =
  match a with
  | Int z -> z
  | Add (e1, e2) -> eval e1 + eval e2
  | Sub (e1, e2) -> eval e1 - eval e2
  | Neg e -> -eval e
  | Div (e1, e2) -> eval e1 / eval e2

(** Evaluation which guards division by zero. *)
let rec safe_eval (a : arith) : int option =
  match a with
  | Int z -> Some z
  | Add (e1, e2) ->
      bind (safe_eval e1) (fun z1 ->
          bind (safe_eval e2) (fun z2 -> Some (z1 + z2)))
  | Sub (e1, e2) ->
      bind (safe_eval e1) (fun z1 ->
          bind (safe_eval e2) (fun z2 -> Some (z1 - z2)))
  | Neg e -> bind (safe_eval e) (fun z -> Some (-z))
  | Div (e1, e2) ->
      bind (safe_eval e1) (fun z1 ->
          bind (safe_eval e2) (fun z2 ->
              if z2 = 0 then None else Some (z1 / z2)))

(** Nicer, monadic notation for [Option.bind]. *)
let ( >>= ) = bind

(** Version of [safe_eval] with monadic bind notation. *)
let rec safe_eval_bind : arith -> int option = function
  | Int z -> Some z
  | Add (e1, e2) ->
      safe_eval_bind e1 >>= fun z1 ->
      safe_eval_bind e2 >>= fun z2 -> Some (z1 + z2)
  | Sub (e1, e2) ->
      safe_eval_bind e1 >>= fun z1 ->
      safe_eval_bind e2 >>= fun z2 -> Some (z1 - z2)
  | Neg e -> safe_eval_bind e >>= fun z -> Some (-z)
  | Div (e1, e2) ->
      safe_eval_bind e1 >>= fun z1 ->
      safe_eval_bind e2 >>= fun z2 -> if z2 = 0 then None else Some (z1 / z2)

(** Even nicer, monadic [Option.bind] notation (analogue to "do syntax" in
    Haskell). *)
let ( let* ) o f = bind o f

(** Now the code is much nicer to read! *)
let rec safe_eval_bind_let : arith -> int option = function
  | Int z -> Some z
  | Add (e1, e2) ->
      let* z1 = safe_eval_bind_let e1 in
      let* z2 = safe_eval_bind_let e2 in
      Some (z1 + z2)
  | Sub (e1, e2) ->
      let* z1 = safe_eval_bind_let e1 in
      let* z2 = safe_eval_bind_let e2 in
      Some (z1 - z2)
  | Neg e ->
      let* z = safe_eval_bind_let e in
      Some (-z)
  | Div (e1, e2) ->
      let* z1 = safe_eval_bind_let e1 in
      let* z2 = safe_eval_bind_let e2 in
      if z2 = 0 then None else Some (z1 / z2)

(** We can take advantage of [Option.map] to remove boilerplate [Some] at the
    end. *)
let ( let+ ) o f = Option.map f o

(** Now we maximize our utility by using [Option.map] to avoid redundant [Some]
    in the final expression. *)
let rec safe_eval_bind_map_let : arith -> int option = function
  | Int z -> Some z
  | Add (e1, e2) ->
      let* z1 = safe_eval_bind_map_let e1 in
      let+ z2 = safe_eval_bind_map_let e2 in
      z1 + z2
  | Sub (e1, e2) ->
      let* z1 = safe_eval_bind_let e1 in
      let+ z2 = safe_eval_bind_let e2 in
      z1 - z2
  | Neg e ->
      let+ z = safe_eval_bind_let e in
      -z
  | Div (e1, e2) ->
      let* z1 = safe_eval_bind_let e1 in
      let* z2 = safe_eval_bind_let e2 in
      if z2 = 0 then None else Some (z1 / z2)

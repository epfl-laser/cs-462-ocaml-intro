open Mylib.Days
open Mylib.Calculator
open Mylib.Lists

let () = assert (day_to_string @@ nth_day Monday 2 = "Wednesday")
let () = assert (foldl 0 (fun acc a -> acc + a) (lst_to_ourlist x) = 6)
let testexp = Add (Nat 5, Div (Mul (Nat 4, Nat 3), Nat 2))
let () = assert (interp testexp = 11)

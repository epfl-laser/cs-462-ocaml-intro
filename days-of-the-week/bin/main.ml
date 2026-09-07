open Days_of_the_week.Calculator

let () = print_endline "Hello, World!"

let testexp = Add (Nat 5, Div (Mul (Nat 4, Nat 3), Nat 2))
let () = assert (interp testexp = 11)
(* let () = assert false;; *)
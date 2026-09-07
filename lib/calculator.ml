(* AST Type as ADT *)
type aexp =
| Nat of int
| Add of aexp * aexp
| Sub of aexp * aexp
| Mul of aexp * aexp
| Div of aexp * aexp

(* Interpreter for calculator language *)
let rec interp (exp: aexp) = match exp with
  | Nat n -> n
  | Add (a, b) -> interp a + interp b
  | Sub (a, b) -> interp a - interp b
  | Mul (a, b) -> interp a * interp b
  | Div (a, b) -> interp a / interp b

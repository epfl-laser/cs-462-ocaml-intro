let x = [1; 2; 3]

type 'a ourlist = Nil | Cons of 'a * 'a ourlist

let rec lst_to_ourlist l = match l with
| [] -> Nil
| x :: xs -> Cons (x, lst_to_ourlist xs)


let rec append lst1 lst2 =
  match lst1 with
  | Nil -> lst2
  | Cons (x, xs) -> Cons (x, append xs lst2)

(* Drop in to utop and test this *)

let rec map f lst1 =
  match lst1 with
  | Nil -> Nil
  | Cons (x, xs) -> Cons (f x, map f xs)

let rec foldl (acc: 'b) (f: 'b -> 'a -> 'b) (lst: 'a ourlist) =
  match lst with
  | Nil -> acc
  | Cons (x, xs) -> foldl (f acc x) f xs

let test = foldl 0 (fun acc a -> acc + a) (lst_to_ourlist x)
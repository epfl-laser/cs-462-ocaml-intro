(* Algebraic data types *)
type days =
  | Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday
  | Sunday

(* Pattern Matching *)
let next_day day = 
  match day with
  | Monday -> Tuesday
  | Tuesday -> Wednesday
  | Wednesday -> Thursday
  | Thursday -> Friday
  | Friday -> Saturday
  | Saturday -> Sunday
  | Sunday -> Monday

(* Recursion *)
let rec nth_day day n = 
  match n with
  | 0 -> day
  | x -> nth_day (next_day day) (n-1)

let rec nth_day day = function 
  | 0 -> day
  | n -> nth_day (next_day day) (n-1)

let day_to_string day = 
  match day with 
  | Monday -> "Monday"
  | Tuesday -> "Tuesday"
  | Wednesday -> "Wednesday"
  | Thursday -> "Thursday"
  | Friday -> "Friday"
  | Saturday -> "Saturday"
  | Sunday -> "Sunday"
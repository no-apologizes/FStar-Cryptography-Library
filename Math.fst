module Math

// This allowed us to use "x +^ 1L" and such instead of "Int64.add x 1L", which doesn't require "open FStar.Int64"
open FStar.Int64

// Stack if it touches memory in any way, Tot(total) if it's just pure math
// total function, meaning it always terminates and is defined for every well-typed input without throwing exceptions or diverging into infinite loops

// let <- like when you do a func or var
// let name <- yeah thats the name of a function
// let name (x <- name of the param : type <- type of param) 
// let name (x:Int64.t) : Tot <- means it's a total function
// let name (x:Int64.t) : Tot Int64.t <- Tot is also the default effect so ommiting it doesn't do anything

// 'l' is for i32
// 'L' is for i64

let make_odd_plain (x:Int64.t) : Tot Int64.t =
  if x %^ 2L = 0L then x +^ 1L
  else x

let make_negative_plain (x:Int64.t) : Tot Int64.t =
  if x >^ 0L then x *^ (-1L)
  else x

let dnea (x:Int32.t) : Int32.t = x
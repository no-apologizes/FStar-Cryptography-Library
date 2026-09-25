module Andie

open FStar.HyperStack.ST
open LowStar.Printf
open Math

// TODO: the requires and such params and 'l' and 'L' stuff
let main () : Stack Int32.t (requires (fun _ -> true)) (ensures (fun _ _ _ -> true)) =
  let x: Int64.t = 5L in
  let y: Int64.t = -3L in
  printf "x: %L\n" (make_odd_plain x) done;
  printf "y: %L\n" (make_odd_plain y) done;

  printf "negative and odd x: %L\n" (make_negative_plain x) done;
  printf "negative and odd y: %L\n" (make_negative_plain y) done;

  0l
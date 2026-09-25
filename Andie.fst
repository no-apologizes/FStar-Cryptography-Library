module Andie

open FStar.HyperStack.ST
open LowStar.Printf
open Math

let main () : Stack Int32.t (requires (fun _ -> true)) (ensures (fun _ _ _ -> true)) =
  let x: Int64.t = 5L in
  let y: Int64.t = -4L in
  printf "x: %L\n" (make_odd_plain x) done;
  printf "y: %L\n" (make_odd_plain y) done;

  // printf "Oh my god this is the worst thing ever(call from Utils.fst): %l\n" (dnea 21l) done;
  0l
module Andie

open FStar.HyperStack.ST
open LowStar.Printf
open Utils

let main () : Stack Int32.t (requires (fun _ -> true)) (ensures (fun _ _ _ -> true)) =
  printf "Oh my god this is the worst thing ever %l\n" (dnea 21l) done;
  42l
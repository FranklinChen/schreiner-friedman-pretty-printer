type info

datatype margin = IN                    (* inward *)
  | EX                                  (* outward *)
  | AT                                  (* as is *)

type action = info -> info
  
(* Constructor *)
val create : unit -> info
val unitAction : action

val nl : margin -> action
val out : string -> action

val at : margin -> action
val cond : margin -> action
val uncond : margin -> action

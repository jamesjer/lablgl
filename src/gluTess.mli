(* $Id: gluTess.mli,v 1.2 1998-04-07 02:07:07 garrigue Exp $ *)

type t

val create : unit -> t

val begins : t -> unit
val ends : t -> unit

val vertex : t -> [double] Raw.t -> ?data:'a -> unit

val next_contour : t -> type:[ccw cw exterior interior unknown] -> unit

(* The following functions are only available in GLU version 1.2 *)

val begin_contour : t -> unit
val end_contour : t -> unit

val begin_polygon : t -> ?data:'a -> unit
val end_polygon : t -> unit

val normal : t -> Gl.vect3 -> unit

type property =
  [boundary_only(bool) tolerance(float)
   winding_rule([abs_geq_two negative nonzero odd positive])]
val property : t -> property -> unit

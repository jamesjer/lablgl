(* $Id: gluTess.mli,v 1.7 2004-07-13 07:55:18 garrigue Exp $ *)
(* Code contributed by Jon Harrop *)

type winding_rule = [`odd|`nonzero|`positive|`negative|`abs_geq_two]

type vertices = (float * float * float) list

val tesselate :
  ?winding:winding_rule -> ?boundary_only:bool -> ?tolerance:float  ->
  vertices list -> unit

type triangles =
  { singles: vertices list; strips: vertices list; fans: vertices list }
    
val tesselate_and_return :
  ?winding:winding_rule -> ?tolerance:float -> vertices list -> triangles

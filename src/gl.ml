(* $Id: gl.ml,v 1.4 1998-01-07 08:52:29 garrigue Exp $ *)

(* Register an exception *)

exception GLerror of string

let _ = Callback.register_exception "glerror" (GLerror "")

(* Plenty of small C wrappers *)

external _clear_color :
    red:float -> green:float -> blue:float -> alpha:float -> unit
    = "ml_glClearColor"
let clear_color :red :green :blue ?:alpha [< 1. >] =
  _clear_color :red :green :blue :alpha

external _color :
    red:float -> green:float -> blue:float -> alpha:float -> unit
    = "ml_glColor4d"
let color :red :green :blue ?:alpha [< 1. >] =
  _color :red :green :blue :alpha

type buffer_bit = [color depth accum stencil]

external clear : buffer_bit list -> unit
    = "ml_glClear"

external flush : unit -> unit = "ml_glFlush"
external finish : unit -> unit = "ml_glFinish"

type point = float * float

external rect : point -> point -> unit
    = "ml_glRect"
external vertex : x:float -> y:float -> ?z:float -> ?w:float -> unit
    = "ml_glVertex"

type begin_enum = [
    points
    lines
    polygon
    triangles
    quads
    line_strip
    line_loop
    triangle_strip
    triangle_fan
    quad_strip     
  ]

external begin_block : begin_enum -> unit
    = "ml_glBegin"
external end_block : unit -> unit
    = "ml_glEnd"

external point_size : float -> unit
    = "ml_glPointSize"
external line_width : float -> unit
    = "ml_glLineWidth"
external line_stipple : factor:int -> pattern:int -> unit
    = "ml_glLineStipple"

external polygon_mode :
    face:[front back both] -> mode:[point line fill] -> unit
    = "ml_glPolygonMode"
external front_face : mode:[cw ccw] -> unit
    = "ml_glFrontFace"
external cull_face : mode:[front back both] -> unit
    = "ml_glCullFace"
external polygon_stipple : mask:string -> unit
    = "ml_glPolygonStipple"

external edge_flag : bool -> unit
    = "ml_glEdgeFlag"

external normal : x:float -> y:float -> z:float -> unit
    = "ml_glNormal3d"

external matrix_mode : [modelview projection texture] -> unit
    = "ml_glMatrixMode"

external load_identity : unit -> unit
    = "ml_glLoadIdentity"

external _load_matrix : float array array -> unit
    = "ml_glLoadMatrix"
let load_matrix m =
  if Array.length m <> 4 then invalid_arg "Gl.load_matrix";
  Array.iter m fun:
    begin fun v ->
      if Array.length v <> 4 then invalid_arg "Gl.load_matrix"
    end;
  _load_matrix m

external _mult_matrix : float array array -> unit
    = "ml_glMultMatrix"
let mult_matrix m =
  if Array.length m <> 4 then invalid_arg "Gl.mult_matrix";
  Array.iter m fun:
    begin fun v ->
      if Array.length v <> 4 then invalid_arg "Gl.mult_matrix"
    end;
  _mult_matrix m

external translate : x:float -> y:float -> z:float -> unit
    = "ml_glTranslated"
external rotate : angle:float -> x:float -> y:float -> z:float -> unit
    = "ml_glRotated"
external scale : x:float -> y:float -> z:float -> unit
    = "ml_glScaled"

external look_at :
    eye:(float * float * float) ->
    center:(float * float * float) ->
    up:(float * float * float) -> unit
    = "ml_gluLookAt"

external frustum :
    left:float -> right:float -> bottom:float ->
    top:float -> near:float -> far:float -> unit
    = "ml_glFrustum"

external perspective :
    fovy:float -> aspect:float -> znear:float -> zfar:float -> unit
    = "ml_gluPerspective"

external ortho :
    left:float -> right:float -> bottom:float ->
    top:float -> near:float -> far:float -> unit
    = "ml_glOrtho"

external ortho2d :
    left:float -> right:float -> bottom:float -> top:float -> unit
    = "ml_gluOrtho2D"

external viewport : x:int -> y:int -> w:int -> h:int -> unit
    = "ml_glViewport"

external depth_range : near:float -> far:float -> unit
    = "ml_glDepthRange"

external push_matrix : unit -> unit
    = "ml_glPushMatrix"
external pop_matrix : unit -> unit
    = "ml_glPopMatrix"

external _clip_plane : plane:int -> equation:float array -> unit
    = "ml_glClipPlane"
let clip_plane :plane :equation =
  if plane < 0 or plane > 5 or Array.length equation <> 4
  then invalid_arg "Gl.clip_plane";
  _clip_plane :plane :equation

type cap = [
      alpha_test
      auto_normal
      blend
      clip_plane0
      clip_plane1
      clip_plane2
      clip_plane3
      clip_plane4
      clip_plane5
   (* color_logic_op *)
      color_material
      cull_face
      depth_test
      dither
      fog
   (* index_logic_op *)
      light0
      light1
      light2
      light3
      light4
      light5
      light6
      light7
      lighting
      line_smooth
      line_stipple
      logic_op
      map1_color_4
      map1_index
      map1_normal
      map1_texture_coord_1
      map1_texture_coord_2
      map1_texture_coord_3
      map1_texture_coord_4
      map1_vertex_3
      map1_vertex_4
      map2_color_4
      map2_index
      map2_normal
      map2_texture_coord_1
      map2_texture_coord_2
      map2_texture_coord_3
      map2_texture_coord_4
      map2_vertex_3
      map2_vertex_4
      normalize
(*    polygon_offset_fill
      polygon_offset_line
      polygon_offset_point *)
      point_smooth
      polygon_smooth
      polygon_stipple
      scissor_test
      stencil_test
      texture_1d
      texture2d
      texture_gen_q
      texture_gen_r
      texture_gen_s
      texture_gen_t
  ]

external enable : cap -> unit = "ml_glEnable"
external disable : cap -> unit = "ml_glDisable"

external shade_model : [flat smooth] -> unit = "ml_glShadeModel"

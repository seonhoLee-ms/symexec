open !IStd

type t = 
  | LVar of Pvar.t
  | LNum of int
  | LNegate of t
  | LPlus of t * t
  | LMinus of t * t
  | LMult of t * t
  | LDiv of t * t

type pc =
  | LTrue
  | LFalse 

val run : t -> t -> pc list -> Z3.Model.model option
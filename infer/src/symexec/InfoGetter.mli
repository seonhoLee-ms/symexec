open! IStd

module F = Format

type t = { 
  jprocs: Typ.Procname.Java.t list;
  pmap: Procdesc.t Typ.Procname.Map.t; 
  entry: Procdesc.t option;
}

val empty : t

val get_pmap : t -> Procdesc.t Typ.Procname.Map.t

val get_entry : t -> Procdesc.t

val infogetter : unit -> t 


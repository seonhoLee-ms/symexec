open! IStd

val main : unit -> unit 

val run : entry:Typ.Procname.t -> timeout:int -> workset:SymbolicDomain.StateSet.t -> SymbolicDomain.StateSet.t


(*ProcCfg.Backward_*)



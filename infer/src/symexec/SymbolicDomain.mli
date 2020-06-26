open! IStd
module F = Format

module Memory : PrettyPrintable.PPMap with type key = Pvar.t

module PathCond : sig
    type t
end

module State : sig 
    type t = {mem: string Memory.t; pc: PathCond.t; curr_node: Procdesc.Node.t}
    val pp : F.formatter -> t -> unit
    
end

module StateSet : PrettyPrintable.PPSet with type elt = State.t


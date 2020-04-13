open! IStd

module Memory : sig
    type t
end

module PathCond : sig
    type t
end

module State : sig 
    type t = {mem: Memory.t; pc: PathCond.t; currnode: Procdesc.Node.t}
end

module StateSet : PrettyPrintable.PPSet with type elt = State.t

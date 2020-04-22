open! IStd
module F = Format

module Memory = struct
  include PrettyPrintable.MakePPMap (struct 
  include Pvar
  let pp = pp Pp.text
  end )
end

module PathCond = struct
    type t = bool
    [@@deriving compare]
end

module State = struct
    type t = {mem: string Memory.t; pc: PathCond.t; currnode: Procdesc.Node.t} [@@deriving compare]
    let rec pp fmt = function
    | {mem; pc; currnode} -> F.fprintf fmt "hoho"
  end

module StateSet = PrettyPrintable.MakePPSet(State)



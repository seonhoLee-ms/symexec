open! IStd
module F = Format

module Memory = struct
  include PrettyPrintable.MakePPMap (struct 
  include Pvar
  let pp = pp Pp.text
  end )
end

module PathCond = struct
    type t = Exp.t option (**)
    [@@deriving compare]
end

module State = struct
    type t = {mem: string Memory.t; pc: PathCond.t; curr_node: Procdesc.Node.t} [@@deriving compare]
    
    let rec pp fmt = function
    | {mem; pc; curr_node} -> F.fprintf fmt "hoho"
    
    let create_initial_state ~memory ~curr_node =
      { mem = memory;
        pc = None;
        curr_node = curr_node;
       } 
    
    let create_state ~memory ~pc ~curr_node =
      { mem = memory;
        pc = pc;
        curr_node = curr_node;
      }

end

module StateSet = PrettyPrintable.MakePPSet(State)



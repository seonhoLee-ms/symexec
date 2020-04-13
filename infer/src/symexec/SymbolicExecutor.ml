open !IStd

let main () = ()

let rec run ~entry ~depth ~workset = workset
    (** 
     * match SymbolicDomain.States.pop with
     * | None -> SymbolicDomain.States.empty  
     * | Some (st, rest)-> 
     *     state' = execute st;
     *
     *  
     *
     *)

open !IStd

let main () = InfoGetter.main ()
  

let rec run ~entry ~timeout ~workset = workset
    (** 
     * match SymbolicDomain.States.pop with
     * | None -> SymbolicDomain.States.empty  
     * | Some (st, rest)-> 
     *     state' = execute st;
     *
     *  
     *
     *)

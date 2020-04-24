open !IStd

module L = Logging

let main () = 
  let info = InfoGetter.infogetter () in
  () 
  
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

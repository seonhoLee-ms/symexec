open !IStd

module L = Logging

let main () = 
  let info = InfoGetter.infogetter () in
  let entry_desc = InfoGetter.get_entry info in
  let entry_node = Procdesc.get_start_node entry_desc in
  L.progress "%a\n" Procdesc.Node.pp entry_node;
  let succs = Procdesc.Node.get_succs entry_node in
  if List.is_empty succs then L.progress "succs is empty!!\n" else L.progress "not empty!!\n";
  L.progress "%a" (Pp.seq ~sep: "||" Procdesc.Node.pp) succs;
  L.progress "\n";
  let next = match List.hd succs with 
  | Some n -> n
  | _ -> L.(die InternalError "Die") in
  let succs2 = Procdesc.Node.get_succs next in
  if List.is_empty succs2 then L.progress "succs is empty!!\n" else L.progress "not empty!!\n";
  L.progress "%a" (Pp.seq ~sep: "||" Procdesc.Node.pp) succs2;
  L.progress "\n"; 
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


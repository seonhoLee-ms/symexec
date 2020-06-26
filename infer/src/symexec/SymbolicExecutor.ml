open !IStd

module L = Logging

let get_instrs_list n = 
  Procdesc.Node.get_instrs n |> Instrs.get_underlying_not_reversed |> Array.to_list

let rec traverse ~pdesc = 

  let entry_node = Procdesc.get_start_node pdesc in
  let exit_node = Procdesc.get_exit_node pdesc in 

  L.progress "entry node %a\n" Procdesc.Node.pp entry_node;
  L.progress "exit node %a\n" Procdesc.Node.pp exit_node;
  
  let succs = Procdesc.Node.get_succs entry_node in 
  if List.is_empty succs then L.progress "succs is empty!!\n" else L.progress "not empty!!\n";
  L.progress "%a" (Pp.seq ~sep: "||" Procdesc.Node.pp) succs;
  L.progress "\n";

  let next = match List.hd succs with 
  | Some n -> n
  | _ -> L.(die InternalError "Die") in
  
  let cur_instrs = get_instrs_list next in
  L.progress "%a\n" (Pp.seq ~sep: "\n" (Sil.pp_instr ~print_types: false Pp.text)) cur_instrs

let main () =
  let info = InfoGetter.infogetter () in
  let entry_desc = InfoGetter.get_entry info in
  traverse ~pdesc:entry_desc;
  ()
  (*
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
  let next2 = match List.hd succs2 with 
  | Some n -> n
  | _ -> L.(die InternalError "Die") in
  let succs3 = Procdesc.Node.get_succs next2 in
  if List.is_empty succs3 then L.progress "succs is empty!!\n" else L.progress "not empty!!\n";
  L.progress "%a" (Pp.seq ~sep: "||" Procdesc.Node.pp) succs3;
  L.progress "\n"; 
  let next3 = match List.hd succs3 with 
  | Some n -> n
  | _ -> L.(die InternalError "Die") in
  let succs4 = Procdesc.Node.get_succs next3 in
  if List.is_empty succs4 then L.progress "succs is empty!!\n" else L.progress "not empty!!\n";
  L.progress "%a" (Pp.seq ~sep: "||" Procdesc.Node.pp) succs4;
  L.progress "\n";
  ()
  *) 


let rec run ~entry ~timeout ~workset = workset
    (*
     * match SymbolicDomain.States.pop with
     * | None -> SymbolicDomain.States.empty  
     * | Some (st, rest)-> 
     *     state' = execute st;
     *
     *  
     *
     *)


open! IStd

module F = Format
module L = Logging

type info = { 
  jprocs: Typ.Procname.Java.t list;
  pmap: Procdesc.t Typ.Procname.Map.t; 
  entry: Procdesc.Node.t;
}

type t = info

let empty:info = {
  jprocs = [];
  pmap =Typ.Procname.Map.empty;
  entry =Procdesc.Node.dummy Typ.Procname.empty_block;
}

let get_infos ~source ~acc= 
  let procs = SourceFiles.proc_names_of_source source in
  let info = List.fold procs ~init:acc
    ~f:(fun acc pname -> 
       let jproc_acc = acc.jprocs in
       let pmap_acc = acc.pmap in
       begin match pname with 
       | Typ.Procname.Java jp -> 
         let pmap = begin match Procdesc.load pname with 
         | Some pdesc -> 
             let pmap = Typ.Procname.Map.add pname pdesc pmap_acc in
             pmap
         | None -> L.progress "%a is not added@." Typ.Procname.pp pname; pmap_acc end 
         in
         let jprocs = jp::jproc_acc in
         {acc with jprocs = jprocs; pmap = pmap;}
       | _ as m-> L.(die InternalError "%s is not java method!" (Typ.Procname.to_string m)) end) 
  in 
  info
  
let find_entry ~info ~classname ~methodname = 
  let entry_name = List.filter info.jprocs ~f: (fun proc -> 
    String.equal (Typ.Procname.Java.get_method proc) methodname &&
    String.equal (Typ.Procname.Java.get_simple_class_name proc) classname) in
  let key = match entry_name with 
    | e::[] -> Typ.Procname.Java e 
    | _ -> L.(die InternalError "given function is not exist") in
  Typ.Procname.Map.find key info.pmap |>
  Procdesc.get_start_node 

let driver () =
  L.progress "fetching IR information start"; 
  let command_arg = Config.function_entry in 
  let entry_class, entry_method = 
  match command_arg with
  | Some x -> 
    let es = String.split_on_chars x ~on:['.'] in
    begin match es with 
    (** input should be classname + '.' + methodname **)
    | cls::meth::[] -> cls, meth 
    | _ -> L.(die InternalError "input format are \"classname\".\"methodname\"!")
    end  
  | None -> L.(die InternalError "entry function is not specified!") 
  in 
  L.progress  "cls: %s meth: %s\n" entry_class entry_method;
  let source_files_all = SourceFiles.get_all ~filter:(fun _ -> true) () in
  let all_info = List.fold source_files_all ~init:empty
    ~f:(fun acc elem -> get_infos ~source:elem ~acc:acc) 
  in 
  let entry = find_entry ~info:all_info ~classname:entry_class ~methodname:entry_method in
  let all_info = {all_info with entry=entry} in
  L.progress "fetching IR information done";
  all_info

let infogetter () = driver ()
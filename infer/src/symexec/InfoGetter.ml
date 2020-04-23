open! IStd

module F = Format
module L = Logging

let get_java_proc_names ~source ~acc= 
  let acc = acc in
  let plist = SourceFiles.proc_names_of_source source in
  let jprocs = List.fold plist ~init:acc
    ~f:(fun acc elem -> 
       begin match elem with 
       | Typ.Procname.Java _ -> elem::acc
       | _ as m-> L.(die InternalError "%s is not java method!" (Typ.Procname.to_string m))  
       end) in 
  L.progress "FileName: %a\n" SourceFile.pp source;
  L.progress "%a" (Pp.seq ~sep: "\n" Typ.Procname.pp) jprocs;
  List.iter jprocs ~f:(fun proc-> 
    match proc with 
    | Typ.Procname.Java x->  L.progress "method name: %s\n" (Typ.Procname.Java.get_method x)
    | _ -> L.progress "None");
  L.progress "\n";
  jprocs

let driver () = 
  let command_arg = Config.function_entry in 
  let entry = match command_arg with
  | Some x -> x
  | None -> L.(die InternalError "entry function is not specified!") in 
  L.progress "entry: %s\n" entry;
  let source_files_all = SourceFiles.get_all ~filter:(fun _ -> true) () in
  let empty = [] in
  let all_procs = List.fold source_files_all ~init:empty 
    ~f:(fun acc elem -> get_java_proc_names ~source:elem ~acc:acc) 
  in 
  L.progress "Process End\n"

let main () = driver ()
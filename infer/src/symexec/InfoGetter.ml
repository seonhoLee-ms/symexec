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
  L.progress "\n";
  jprocs

let main () = 
  let source_files_all = SourceFiles.get_all ~filter:(fun _ -> true) () in
  let empty = [] in
  let all_procs = List.fold source_files_all ~init:empty 
    ~f:(fun acc elem -> get_java_proc_names ~source:elem ~acc:acc) 
  in 
  L.progress "Process End\n";
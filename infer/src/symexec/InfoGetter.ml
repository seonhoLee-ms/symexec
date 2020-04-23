open! IStd

module F = Format
module L = Logging

let rec run ~lst = 
 match lst with
 | [] -> L.progress "\nAll Files End\n"
 | h::t -> 
   let plist = SourceFiles.proc_names_of_source h in
   begin match plist with 
   | [] -> L.progress "File End\n"
   | h::t -> L.progress "%a" Typ.Procname.pp h
   end;
   run ~lst:t 
 
 (*SourceFiles.pp_all ~filter:(fun _ -> true) ~type_environment: true
           ~procedure_names: true ~freshly_captured: false F.Acc_string_literal  run ~lst:t*)

let main () = 
  let source_files_all = SourceFiles.get_all ~filter:(fun _ -> true) () in
  run source_files_all
  
 
  





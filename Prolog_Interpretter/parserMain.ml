open DataTypes;;
open PrintFunc;;
open Lexing;;
open ParserTypes;;
open ProLogInterpret;;
open ParserPrint;;
Printf.printf "outside main function here";;
let main () = 
  Printf.printf "Calcualted txt\n";;let input = if Array.length Sys.argv > 1
              then open_in Sys.argv.(1)
              else stdin
            in 
  let fileName = if Array.length Sys.argv > 1
                    then Sys.argv.(1)
                    else ""
  in let lexbuf = Lexing.from_channel input in
  try 
    Printf.printf "Calcualted txt\n";set_filename lexbuf fileName;Printf.printf "File_name %s" fileName;
    let prog,_ = ProLogParse.program ProLogLex.prologParse lexbuf 
    in 
      let progTrans = translateClauseArr prog in
        Printf.printf "Calcualted txt\n";
        let txt = ParserPrint.sprintProg progTrans in
        (*let progAsArr = ProLogInterpret.lstToArr progTrans (defultClause,0) in*) 
          Printf.printf "%s" txt;
        let goalFileName = Sys.argv.(2) in 
        let inputStream = open_in goalFileName in 
        let lexbuf = Lexing.from_channel inputStream in 
        set_filename lexbuf goalFileName;
        let _,goalArr = ProLogParse.program ProLogLex.prologParse lexbuf in 
        let txt = sprintGoal goalArr in 
          Printf.printf "Goals are:\n%s" txt;
          print_newline ();
          solveGoal goalArr progTrans
with 
  | DataTypes.UnrecognizedToken errorMsg -> Printf.printf "Lexing error at:\n%s" errorMsg; print_newline ()
  | ParserTypes.ProLogParseError errorMsg -> Printf.printf "\nParsing error at:\n%s" errorMsg; print_newline ()
  
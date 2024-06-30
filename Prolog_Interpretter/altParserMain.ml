open DataTypes;;
open PrintFunc;;
open Lexing;;
open ParserTypes;;
open ProLogInterpret;;
open ParserPrint;;

let rec mainFunc progTrans curStateOption = 
  Printf.printf "? ";
  let curTxt = read_line () in 
    if curTxt = "" then 
      (
      match curStateOption with
      | Some curState -> 
          Printf.printf "Alternate solutions are:";print_newline ();
          let nextState = findNextPossibility curState in 
          let newState,validAns = solveGoal [] progTrans (Some nextState) in 
            if validAns then 
              mainFunc progTrans (Some newState)
            else 
              mainFunc progTrans None
      | None ->
          Printf.printf "No furthur possibilities to solve";print_newline ();
              mainFunc progTrans None)
    else 
      let curTxt = "? "^curTxt in
      let lexbuf = from_string curTxt in 
      set_filename lexbuf "stdin";
      try 
          let _,goalArr = ProLogParse.program ProLogLex.prologParse lexbuf in 
          let txt = sprintGoal goalArr in 
            (*Printf.printf "Parsed goal is:\n%s" txt;*)
            print_newline ();
            let curState,validAns = solveGoal goalArr progTrans None in 
              if validAns then 
                  mainFunc progTrans (Some curState)  
              else
                  mainFunc progTrans None 
      with 
      | DataTypes.UnrecognizedToken errorMsg -> Printf.printf "Lexing error at:\n%s" errorMsg;print_newline ();mainFunc progTrans None
      | ParserTypes.ProLogParseError errorMsg -> Printf.printf "Parsing error at:\n%s" errorMsg;print_newline ();mainFunc progTrans None
    ;; 
let main () = 
  Printf.printf "Calcualted txt\n";let input = if Array.length Sys.argv > 1
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
          mainFunc progTrans None
        (*
        let goalFileName = Sys.argv.(2) in 
        let inputStream = open_in goalFileName in 
        let lexbuf = Lexing.from_channel inputStream in 
        set_filename lexbuf goalFileName;
        let _,goalArr = ProLogParse.program ProLogLex.prologParse lexbuf in 
        let txt = sprintGoal goalArr in 
          Printf.printf "Goals are:\n%s" txt;
          print_newline ();
          solveGoal goalArr progTrans
        *)
with 
  | DataTypes.UnrecognizedToken errorMsg -> Printf.printf "Lexing error at:\n%s" errorMsg; print_newline ()
  | ParserTypes.ProLogParseError errorMsg -> Printf.printf "\nParsing error at:\n%s" errorMsg; print_newline ();;
main ()
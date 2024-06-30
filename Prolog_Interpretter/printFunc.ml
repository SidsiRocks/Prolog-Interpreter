open DataTypes;;
open ProLogParse;;
let printToken token = match token with 
| LFTBRAC -> "LFTBRAC ("
| RGTBRAC -> "RGTBRAC )"

| COMMA -> "COMMA ,"
| VAR varTxt -> Printf.sprintf "VAR %s" varTxt 
| CONST constTxt -> Printf.sprintf "CONST %s" constTxt

| GIVEN -> "GIVEN :-"
| PREDEND -> "PREDEND ;"

| QUESTION -> "?"
| FILE_END -> "FILE_END ^D"

let printTokenArr tokenArr = 
  let rec helperPrintTokenArr tokenArr = match tokenArr with
  | []     ->  ()
  | x::rem -> Printf.printf "%s" (printToken x);Printf.printf ",";helperPrintTokenArr rem
      in
    Printf.printf "["; helperPrintTokenArr tokenArr;Printf.printf "]"


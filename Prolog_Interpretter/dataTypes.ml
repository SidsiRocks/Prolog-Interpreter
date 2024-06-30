(*
type tokens = 
| LFTBRAC 
| RGTBRAC 
(*Add list brackets later here perhaps*)
| COMMA 
| VAR of string 
| CONST of string 
(*Add ints here later*)
| GIVEN 
| PREDEND 

(*grammar for goals separately defined*)
| QUESTION
| FILE_END 
(*Add arithmetic operations here later*)
*)


exception UnrecognizedToken of string


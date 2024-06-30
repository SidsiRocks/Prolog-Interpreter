type token =
  | LFTBRAC
  | RGTBRAC
  | COMMA
  | VAR of (string)
  | CONST of (string)
  | GIVEN
  | PREDEND
  | QUESTION
  | FILE_END

val goal :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> ParserTypes.atomic_formula_list

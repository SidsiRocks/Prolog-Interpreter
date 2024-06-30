type token =
  | LFTBRAC
  | RGTBRAC
  | COMMA
  | QUESTION
  | PIPE
  | VAR of (string)
  | CONST of (string)
  | GIVEN
  | PREDEND
  | FILE_END
  | SQRLFT
  | SQRRGT

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> ParserTypes.program * ParserTypes.atomic_formula_list

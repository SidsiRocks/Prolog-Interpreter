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

open Parsing;;
let _ = parse_error;;
# 2 "proLogGoalParse.mly"
    open Lexing;; (*not sure if needed directly here*)

    let list_rev lst = 
        let rec list_rev_helper lst1 lst2 =
            (match lst1 with 
            | []      -> lst2 
            | x::lst1 -> list_rev_helper lst1 (x::lst2)
            ) 
        in 
            list_rev_helper lst []
    let writeErrorMsg startPos = 
        Printf.sprintf "File \"%s\", line %d, characters %d" 
            startPos.pos_fname startPos.pos_lnum (startPos.pos_cnum - startPos.pos_bol)

# 30 "proLogGoalParse.ml"
let yytransl_const = [|
  257 (* LFTBRAC *);
  258 (* RGTBRAC *);
  259 (* COMMA *);
  262 (* GIVEN *);
  263 (* PREDEND *);
  264 (* QUESTION *);
  265 (* FILE_END *);
    0|]

let yytransl_block = [|
  260 (* VAR *);
  261 (* CONST *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\003\000\003\000\004\000\004\000\
\004\000\005\000\005\000\006\000\006\000\007\000\007\000\008\000\
\008\000\009\000\009\000\009\000\010\000\010\000\011\000\011\000\
\012\000\012\000\012\000\013\000\013\000\013\000\000\000"

let yylen = "\002\000\
\001\000\002\000\001\000\000\000\002\000\001\000\001\000\001\000\
\001\000\002\000\001\000\004\000\001\000\001\000\001\000\001\000\
\001\000\001\000\003\000\001\000\000\000\001\000\004\000\001\000\
\000\000\003\000\001\000\001\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\031\000\001\000\000\000\000\000\
\000\000\024\000\029\000\000\000\028\000\000\000\000\000\019\000\
\023\000\000\000\026\000"

let yydgoto = "\002\000\
\005\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\006\000\000\000\007\000\014\000\015\000"

let yysindex = "\003\000\
\003\255\000\000\000\000\004\255\000\000\000\000\006\255\002\255\
\003\255\000\000\000\000\004\255\000\000\011\255\012\255\000\000\
\000\000\002\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\001\000\000\000\000\000\000\000\014\000\014\255\
\000\000\000\000\000\000\009\255\000\000\000\000\015\255\000\000\
\000\000\014\255\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\009\000\000\000\248\255\002\000\000\000"

let yytablesize = 260
let yytable = "\013\000\
\020\000\010\000\003\000\001\000\008\000\011\000\012\000\004\000\
\009\000\013\000\030\000\030\000\017\000\018\000\018\000\025\000\
\027\000\016\000\000\000\019\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\024\000"

let yycheck = "\008\000\
\000\000\000\001\000\001\001\000\001\001\004\001\005\001\005\001\
\003\001\018\000\002\001\003\001\002\001\000\000\003\001\002\001\
\002\001\009\000\255\255\018\000\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\003\001"

let yynames_const = "\
  LFTBRAC\000\
  RGTBRAC\000\
  COMMA\000\
  GIVEN\000\
  PREDEND\000\
  QUESTION\000\
  FILE_END\000\
  "

let yynames_block = "\
  VAR\000\
  CONST\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula_list) in
    Obj.repr(
# 38 "proLogGoalParse.mly"
                                        (_1)
# 174 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.clause_list) in
    Obj.repr(
# 40 "proLogGoalParse.mly"
                          (_1)
# 181 "proLogGoalParse.ml"
               : ParserTypes.program))
; (fun __caml_parser_env ->
    Obj.repr(
# 41 "proLogGoalParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 187 "proLogGoalParse.ml"
               : ParserTypes.program))
; (fun __caml_parser_env ->
    Obj.repr(
# 44 "proLogGoalParse.mly"
                ([])
# 193 "proLogGoalParse.ml"
               : ParserTypes.clause_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.clause) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.clause_list) in
    Obj.repr(
# 45 "proLogGoalParse.mly"
                         (_1::_2)
# 201 "proLogGoalParse.ml"
               : ParserTypes.clause_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 46 "proLogGoalParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 207 "proLogGoalParse.ml"
               : ParserTypes.clause_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula) in
    Obj.repr(
# 49 "proLogGoalParse.mly"
           (_1,[])
# 214 "proLogGoalParse.ml"
               : ParserTypes.clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.rule) in
    Obj.repr(
# 50 "proLogGoalParse.mly"
           (_1)
# 221 "proLogGoalParse.ml"
               : ParserTypes.clause))
; (fun __caml_parser_env ->
    Obj.repr(
# 51 "proLogGoalParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 227 "proLogGoalParse.ml"
               : ParserTypes.clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.atomic_formula) in
    Obj.repr(
# 54 "proLogGoalParse.mly"
                   (_1)
# 234 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula))
; (fun __caml_parser_env ->
    Obj.repr(
# 55 "proLogGoalParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 240 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : ParserTypes.atomic_formula) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.atomic_formula_list) in
    Obj.repr(
# 58 "proLogGoalParse.mly"
                              (_1,_3)
# 248 "proLogGoalParse.ml"
               : ParserTypes.rule))
; (fun __caml_parser_env ->
    Obj.repr(
# 59 "proLogGoalParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 254 "proLogGoalParse.ml"
               : ParserTypes.rule))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula) in
    Obj.repr(
# 62 "proLogGoalParse.mly"
                     (_1)
# 261 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula))
; (fun __caml_parser_env ->
    Obj.repr(
# 63 "proLogGoalParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 267 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula_list) in
    Obj.repr(
# 66 "proLogGoalParse.mly"
                                    (_1)
# 274 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 67 "proLogGoalParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 280 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula) in
    Obj.repr(
# 70 "proLogGoalParse.mly"
                     ([_1])
# 287 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : ParserTypes.atomic_formula) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula_list) in
    Obj.repr(
# 71 "proLogGoalParse.mly"
                                                         (_1::_3)
# 295 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 72 "proLogGoalParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 301 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 75 "proLogGoalParse.mly"
                ([])
# 307 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula_list) in
    Obj.repr(
# 76 "proLogGoalParse.mly"
                                    (_1)
# 314 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.term_list) in
    Obj.repr(
# 79 "proLogGoalParse.mly"
                                      (_1,_3)
# 322 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula))
; (fun __caml_parser_env ->
    Obj.repr(
# 80 "proLogGoalParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 328 "proLogGoalParse.ml"
               : ParserTypes.atomic_formula))
; (fun __caml_parser_env ->
    Obj.repr(
# 83 "proLogGoalParse.mly"
                ([])
# 334 "proLogGoalParse.ml"
               : ParserTypes.term_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : ParserTypes.term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.term_list) in
    Obj.repr(
# 84 "proLogGoalParse.mly"
                           (_1::_3)
# 342 "proLogGoalParse.ml"
               : ParserTypes.term_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.term) in
    Obj.repr(
# 85 "proLogGoalParse.mly"
           ([_1])
# 349 "proLogGoalParse.ml"
               : ParserTypes.term_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula) in
    Obj.repr(
# 88 "proLogGoalParse.mly"
                     (ParserTypes.Atomic _1)
# 356 "proLogGoalParse.ml"
               : ParserTypes.term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 89 "proLogGoalParse.mly"
          (ParserTypes.Var(ParserTypes.NormalVar _1))
# 363 "proLogGoalParse.ml"
               : ParserTypes.term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 90 "proLogGoalParse.mly"
            (ParserTypes.Const _1)
# 370 "proLogGoalParse.ml"
               : ParserTypes.term))
(* Entry goal *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let goal (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : ParserTypes.atomic_formula_list)
;;

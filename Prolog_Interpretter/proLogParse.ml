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

open Parsing;;
let _ = parse_error;;
# 2 "proLogParse.mly"
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

# 33 "proLogParse.ml"
let yytransl_const = [|
  257 (* LFTBRAC *);
  258 (* RGTBRAC *);
  259 (* COMMA *);
  260 (* QUESTION *);
  261 (* PIPE *);
  264 (* GIVEN *);
  265 (* PREDEND *);
  266 (* FILE_END *);
  267 (* SQRLFT *);
  268 (* SQRRGT *);
    0|]

let yytransl_block = [|
  262 (* VAR *);
  263 (* CONST *);
    0|]

let yylhs = "\255\255\
\013\000\013\000\001\000\001\000\002\000\002\000\002\000\003\000\
\003\000\003\000\004\000\004\000\005\000\005\000\006\000\006\000\
\007\000\007\000\008\000\008\000\008\000\009\000\009\000\010\000\
\010\000\014\000\014\000\015\000\015\000\011\000\011\000\016\000\
\016\000\012\000\012\000\012\000\012\000\012\000\000\000"

let yylen = "\002\000\
\000\000\002\000\003\000\001\000\000\000\002\000\001\000\001\000\
\001\000\001\000\002\000\001\000\004\000\001\000\001\000\001\000\
\001\000\001\000\001\000\003\000\001\000\000\000\001\000\004\000\
\001\000\003\000\001\000\001\000\003\000\000\000\001\000\003\000\
\005\000\001\000\001\000\001\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\039\000\000\000\000\000\008\000\
\009\000\000\000\015\000\000\000\000\000\000\000\000\000\006\000\
\000\000\011\000\025\000\000\000\035\000\000\000\000\000\034\000\
\000\000\000\000\038\000\031\000\037\000\000\000\023\000\002\000\
\000\000\003\000\000\000\000\000\017\000\000\000\000\000\000\000\
\024\000\000\000\000\000\013\000\026\000\032\000\000\000\029\000\
\020\000\000\000\033\000"

let yydgoto = "\002\000\
\005\000\006\000\007\000\008\000\009\000\010\000\036\000\031\000\
\032\000\024\000\025\000\026\000\014\000\027\000\028\000\029\000"

let yysindex = "\004\000\
\003\255\000\000\000\000\048\255\000\000\047\255\011\255\000\000\
\000\000\046\255\000\000\008\255\031\255\035\255\000\000\000\000\
\041\255\000\000\000\000\008\255\000\000\048\255\008\255\000\000\
\054\255\055\255\000\000\000\000\000\000\000\000\000\000\000\000\
\056\255\000\000\000\000\051\255\000\000\059\255\038\255\052\255\
\000\000\008\255\031\255\000\000\000\000\000\000\008\255\000\000\
\000\000\050\255\000\000"

let yyrindex = "\000\000\
\042\255\000\000\001\000\000\000\000\000\053\255\042\255\000\000\
\000\000\000\000\000\000\062\255\057\255\000\000\013\255\000\000\
\000\000\000\000\000\000\062\255\000\000\022\255\058\255\000\000\
\000\000\027\255\000\000\000\000\000\000\034\255\000\000\000\000\
\026\255\000\000\044\255\000\000\000\000\000\000\000\000\060\255\
\000\000\028\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\058\000\000\000\000\000\000\000\000\000\000\000\241\255\
\000\000\255\255\240\255\019\000\000\000\000\000\045\000\000\000"

let yytablesize = 267
let yytable = "\011\000\
\004\000\037\000\003\000\038\000\001\000\011\000\039\000\019\000\
\020\000\004\000\015\000\033\000\010\000\021\000\022\000\033\000\
\007\000\004\000\023\000\010\000\016\000\016\000\007\000\036\000\
\036\000\048\000\036\000\049\000\028\000\030\000\030\000\028\000\
\030\000\036\000\019\000\019\000\025\000\004\000\028\000\030\000\
\035\000\033\000\021\000\021\000\034\000\005\000\025\000\004\000\
\012\000\046\000\013\000\005\000\018\000\017\000\018\000\041\000\
\047\000\042\000\043\000\044\000\045\000\051\000\001\000\030\000\
\016\000\050\000\022\000\040\000\000\000\030\000\000\000\031\000\
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
\010\000\000\000\000\000\000\000\007\000\000\000\000\000\010\000\
\016\000\016\000\007\000"

let yycheck = "\001\000\
\000\000\017\000\000\001\020\000\001\000\007\000\023\000\000\001\
\001\001\007\001\000\001\013\000\000\001\006\001\007\001\017\000\
\004\001\007\001\011\001\007\001\008\001\009\001\010\001\002\001\
\003\001\042\000\005\001\043\000\002\001\002\001\000\001\005\001\
\005\001\012\001\009\001\010\001\003\001\007\001\012\001\012\001\
\000\001\043\000\009\001\010\001\010\001\004\001\003\001\007\001\
\001\001\012\001\004\001\010\001\009\001\008\001\009\001\002\001\
\005\001\003\001\003\001\009\001\002\001\012\001\010\001\002\001\
\007\000\047\000\010\001\023\000\255\255\012\001\255\255\012\001\
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
\000\001\255\255\255\255\255\255\004\001\255\255\255\255\007\001\
\008\001\009\001\010\001"

let yynames_const = "\
  LFTBRAC\000\
  RGTBRAC\000\
  COMMA\000\
  QUESTION\000\
  PIPE\000\
  GIVEN\000\
  PREDEND\000\
  FILE_END\000\
  SQRLFT\000\
  SQRRGT\000\
  "

let yynames_block = "\
  VAR\000\
  CONST\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "proLogParse.mly"
                ([])
# 198 "proLogParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula_list) in
    Obj.repr(
# 40 "proLogParse.mly"
                                   (_2)
# 205 "proLogParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : ParserTypes.clause_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.atomic_formula_list) in
    Obj.repr(
# 42 "proLogParse.mly"
                               (_1,_2)
# 213 "proLogParse.ml"
               : ParserTypes.program * ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 43 "proLogParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 219 "proLogParse.ml"
               : ParserTypes.program * ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 46 "proLogParse.mly"
                ([])
# 225 "proLogParse.ml"
               : ParserTypes.clause_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.clause) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.clause_list) in
    Obj.repr(
# 47 "proLogParse.mly"
                         (_1::_2)
# 233 "proLogParse.ml"
               : ParserTypes.clause_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 48 "proLogParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 239 "proLogParse.ml"
               : ParserTypes.clause_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula) in
    Obj.repr(
# 51 "proLogParse.mly"
           (_1,[])
# 246 "proLogParse.ml"
               : ParserTypes.clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.rule) in
    Obj.repr(
# 52 "proLogParse.mly"
           (_1)
# 253 "proLogParse.ml"
               : ParserTypes.clause))
; (fun __caml_parser_env ->
    Obj.repr(
# 53 "proLogParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 259 "proLogParse.ml"
               : ParserTypes.clause))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.atomic_formula) in
    Obj.repr(
# 56 "proLogParse.mly"
                   (_1)
# 266 "proLogParse.ml"
               : ParserTypes.atomic_formula))
; (fun __caml_parser_env ->
    Obj.repr(
# 57 "proLogParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 272 "proLogParse.ml"
               : ParserTypes.atomic_formula))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : ParserTypes.atomic_formula) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.atomic_formula_list) in
    Obj.repr(
# 60 "proLogParse.mly"
                              (_1,_3)
# 280 "proLogParse.ml"
               : ParserTypes.rule))
; (fun __caml_parser_env ->
    Obj.repr(
# 61 "proLogParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 286 "proLogParse.ml"
               : ParserTypes.rule))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula) in
    Obj.repr(
# 64 "proLogParse.mly"
                     (_1)
# 293 "proLogParse.ml"
               : ParserTypes.atomic_formula))
; (fun __caml_parser_env ->
    Obj.repr(
# 65 "proLogParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 299 "proLogParse.ml"
               : ParserTypes.atomic_formula))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula_list) in
    Obj.repr(
# 68 "proLogParse.mly"
                                    (_1)
# 306 "proLogParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 69 "proLogParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 312 "proLogParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula) in
    Obj.repr(
# 72 "proLogParse.mly"
                     ([_1])
# 319 "proLogParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : ParserTypes.atomic_formula) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula_list) in
    Obj.repr(
# 73 "proLogParse.mly"
                                                         (_1::_3)
# 327 "proLogParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 74 "proLogParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 333 "proLogParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 77 "proLogParse.mly"
                ([])
# 339 "proLogParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula_list) in
    Obj.repr(
# 78 "proLogParse.mly"
                                    (_1)
# 346 "proLogParse.ml"
               : ParserTypes.atomic_formula_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.term_list) in
    Obj.repr(
# 81 "proLogParse.mly"
                                      (_1,_3)
# 354 "proLogParse.ml"
               : ParserTypes.atomic_formula))
; (fun __caml_parser_env ->
    Obj.repr(
# 82 "proLogParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 360 "proLogParse.ml"
               : ParserTypes.atomic_formula))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.term_list) in
    Obj.repr(
# 85 "proLogParse.mly"
                                ("",_2)
# 367 "proLogParse.ml"
               : 'tuple))
; (fun __caml_parser_env ->
    Obj.repr(
# 86 "proLogParse.mly"
            (raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) ))
# 373 "proLogParse.ml"
               : 'tuple))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.term) in
    Obj.repr(
# 89 "proLogParse.mly"
           ([_1])
# 380 "proLogParse.ml"
               : 'term_list_non_empty))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : ParserTypes.term) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.term_list) in
    Obj.repr(
# 90 "proLogParse.mly"
                           (_1::_3)
# 388 "proLogParse.ml"
               : 'term_list_non_empty))
; (fun __caml_parser_env ->
    Obj.repr(
# 93 "proLogParse.mly"
                ([])
# 394 "proLogParse.ml"
               : ParserTypes.term_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term_list_non_empty) in
    Obj.repr(
# 94 "proLogParse.mly"
                          (_1)
# 401 "proLogParse.ml"
               : ParserTypes.term_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.term_list) in
    Obj.repr(
# 97 "proLogParse.mly"
                              ((ParserTypes.lstToPred (_2,None)))
# 408 "proLogParse.ml"
               : 'list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'term_list_non_empty) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : ParserTypes.term) in
    Obj.repr(
# 98 "proLogParse.mly"
                                                  ((ParserTypes.lstToPred (_2,(Some _4))))
# 416 "proLogParse.ml"
               : 'list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : ParserTypes.atomic_formula) in
    Obj.repr(
# 101 "proLogParse.mly"
                     (ParserTypes.Atomic _1)
# 423 "proLogParse.ml"
               : ParserTypes.term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 102 "proLogParse.mly"
          (ParserTypes.Var(ParserTypes.NormalVar _1))
# 430 "proLogParse.ml"
               : ParserTypes.term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 103 "proLogParse.mly"
            (ParserTypes.Const _1)
# 437 "proLogParse.ml"
               : ParserTypes.term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'list) in
    Obj.repr(
# 104 "proLogParse.mly"
           (_1)
# 444 "proLogParse.ml"
               : ParserTypes.term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'tuple) in
    Obj.repr(
# 105 "proLogParse.mly"
            (ParserTypes.Atomic _1)
# 451 "proLogParse.ml"
               : ParserTypes.term))
(* Entry program *)
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
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : ParserTypes.program * ParserTypes.atomic_formula_list)
;;

%{
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

%}

%token LFTBRAC RGTBRAC COMMA QUESTION PIPE 
%token <string> VAR CONST
%token GIVEN PREDEND QUESTION FILE_END SQRLFT SQRRGT

%start program

%type <ParserTypes.program * ParserTypes.atomic_formula_list> program
%type <ParserTypes.clause_list> clause_list
%type <ParserTypes.clause> clause
%type <ParserTypes.atomic_formula> fact 
%type <ParserTypes.rule> rule 
%type <ParserTypes.atomic_formula> head
%type <ParserTypes.atomic_formula_list> body 
%type <ParserTypes.atomic_formula_list> atomic_formula_list_non_empty
%type <ParserTypes.atomic_formula_list> atomic_formula_list
%type <ParserTypes.atomic_formula> atomic_formula
%type <ParserTypes.term_list> term_list
%type <ParserTypes.term> term
%type <ParserTypes.atomic_formula_list> goal
%%
    goal: 
    | /*empty*/ {[]}
    | QUESTION atomic_formula_list {$2}
    program:
    | clause_list goal FILE_END{$1,$2}
    | error {raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) )}

    clause_list:
    | /*empty*/ {[]}
    | clause clause_list {$1::$2} /*do not need to reverse here*/
    | error {raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) )}

    clause: 
    | fact {$1,[]}
    | rule {$1}
    | error {raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) )}

    fact:
    | head PREDEND {$1}
    | error {raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) )}

    rule:
    | head GIVEN body PREDEND {$1,$3}
    | error {raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) )}

    head:
    | atomic_formula {$1}    
    | error {raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) )}

    body:
    | atomic_formula_list_non_empty {$1}
    | error {raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) )}

    atomic_formula_list_non_empty:
    | atomic_formula {[$1]}
    | atomic_formula COMMA atomic_formula_list_non_empty {$1::$3}
    | error {raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) )}

    atomic_formula_list:
    | /*empty*/ {[]}
    | atomic_formula_list_non_empty {$1}

    atomic_formula:
    | CONST LFTBRAC term_list RGTBRAC {$1,$3}
    | error {raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) )}

    tuple:
    | LFTBRAC term_list RGTBRAC {"",$2}
    | error {raise (ParserTypes.ProLogParseError (writeErrorMsg (symbol_start_pos ())) )}

    term_list_non_empty:
    | term {[$1]}
    | term COMMA term_list {$1::$3}

    term_list:
    | /*empty*/ {[]}
    | term_list_non_empty {$1}

    list:
    | SQRLFT term_list SQRRGT {(ParserTypes.lstToPred ($2,None))}
    | SQRLFT term_list_non_empty PIPE term SQRRGT {(ParserTypes.lstToPred ($2,(Some $4)))}

    term:
    | atomic_formula {ParserTypes.Atomic $1}
    | VAR {ParserTypes.Var(ParserTypes.NormalVar $1)}
    | CONST {ParserTypes.Const $1}
    | list {$1}
    | tuple {ParserTypes.Atomic $1}
%%

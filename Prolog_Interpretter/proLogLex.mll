{
    open DataTypes;;
    open ProLogParse;;
    open Lexing;;

    let writeErrorMsg token startPos = 
        Printf.sprintf "Unrecognized char at:\n File \"%s\", line %d, characters %d \n" 
            startPos.pos_fname startPos.pos_lnum (startPos.pos_cnum - startPos.pos_bol)
}

let upperChar = ['A'-'Z']
let lowerChar = ['a'-'z']
let variableChar = ['_' 'a'-'z' 'A'-'Z' '0'-'9']
let const = lowerChar variableChar*
let variable = (upperChar variableChar*) (*conider adding underscore here later*)
let sep = [' ' '\t']
let implies = ":-"
let question = "?" (*not sure if would be actually using this*)
let singleLineComment = "//"_*
let anyChar = _|'\n' (*rechcek why nedd anychar*)

rule prologParse = parse 
| '(' {LFTBRAC}
| ')' {RGTBRAC}
| ',' {COMMA}
| '?' {QUESTION}
| '|' {PIPE}
| '[' {SQRLFT}
| ']' {SQRRGT}
| question {QUESTION}
| variable as varTxt { VAR varTxt}
| const as constTxt {CONST constTxt}
| implies {GIVEN}
| ';' {PREDEND}
| sep {prologParse lexbuf}
| singleLineComment {prologParse lexbuf}
| '\n' {new_line lexbuf;prologParse lexbuf} (*updated new line for debugging*)
| eof {FILE_END}
| _ {raise (UnrecognizedToken (writeErrorMsg (lexeme lexbuf) (lexeme_end_p lexbuf)))}

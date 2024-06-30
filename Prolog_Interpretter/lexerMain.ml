open PrintFunc;;
let list_rev lst = 
    let rec list_rev_helper l1 l2 = match l1 with 
    | [] -> l2 
    | x::l1 -> list_rev_helper l1 (x::l2) in 
      list_rev_helper lst []
let input = (if Array.length Sys.argv > 1
              then open_in Sys.argv.(1)
              else stdin) 
let lexbuf = Lexing.from_channel input  
let rec parseTokenArr tokenArr lexbuf = 
  let curToken = ProLogLex.prologParse lexbuf in 
    (
        match curToken with 
      | FILE_END -> list_rev tokenArr
      | x -> parseTokenArr (x::tokenArr) lexbuf
    )
let result = printTokenArr (parseTokenArr [] lexbuf);print_newline ()

(*
            in let lexbuf = Lexing.from_channel input 
          in 
            let rec parseTokenTillEnd tokenArr lexbuf = 
                let curToken = ProglogLex.prologParse lexbuf in 
                  match curToken with 
                | FILE_END -> list_rev curToken
                | x -> parseTokenTillEnd (x::tokenArr) lexbuf
            in 
              let tokenArr =  parseTokenTillEnd [] lexbuf

*)
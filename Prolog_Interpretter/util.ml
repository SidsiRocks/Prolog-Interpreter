let lstEmpty lst = 
  match lst with 
  | [] -> true 
  | _::_ -> false
let lstToLstIndx lst mapFunc = 
  let rec lstToIndxHelper lst indx mapFunc = 
    match lst with 
    | [] -> []
    | x::rem -> (x,mapFunc indx)::(lstToIndxHelper rem (indx+1) mapFunc)
  in 
    lstToIndxHelper lst 0 mapFunc
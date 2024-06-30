type var = 
| NormalVar of string 
| TempVar of int
type constPred = string
type term = 
| Atomic of atomic_formula
| Var of var 
| Const of string 
and atomic_formula = constPred*(term list) 
type atomic_formula_list = atomic_formula list
type term_list = term list
type head = atomic_formula
type clause = head*(atomic_formula list)
type clause_list = clause list
type program = clause list
type rule = atomic_formula*(atomic_formula list)

type substTable = (var*term) list

exception ProLogParseError of string


let atomToTerm atom = Atomic atom
exception TermIsNotAtom of term
let termToAtom term = match term with
| Atomic atomicFormula -> atomicFormula
| _ -> (raise (TermIsNotAtom term))


let rec elmInLst elm lst = match lst with 
| [] -> false
| x::rem -> if x = elm then true else elmInLst elm rem
  let rec varsAtomicHelper atomic_formula curVars = 
    match atomic_formula with 
    | constPred,term_list -> varsTermList term_list curVars
  and varsAtomicList atomic_formula_list = 
    let term_formula_list = List.map (fun atom -> (Atomic atom)) atomic_formula_list in 
      varsTermList term_formula_list
  and varsTermList termLst curVars = 
    match termLst with 
    | [] -> curVars
    | term::termLst -> varsTermList termLst (varsTerm term curVars)
  and varsTerm term curVars = 
    match term with 
    | Atomic atomic_formula -> varsAtomicHelper atomic_formula curVars
    | Var var -> if (elmInLst var curVars) then curVars else (var::curVars)
    | Const string -> curVars
  and varsClause clause curVars = 
    match clause with
    | head,atomic_formula_list -> let newVars = varsAtomicHelper head curVars in  
                                  let newVars = varsTermList (List.map atomToTerm atomic_formula_list) newVars in 
                                    newVars
exception VariableNotInTable of var


let rec lookup var substTable = 
  match substTable with
  | [] -> (raise (VariableNotInTable var))
  | (var2,value)::rem -> if var = var2 then value else lookup var rem

let rec varInTable var substTable = 
  match substTable with
  | [] -> (false,Var var) 
  | (var2,value)::rem -> if var = var2 then (true,value) else varInTable var rem

let rec subst table term = 
  match term with
  | Var var -> let isPres,termMatch = varInTable var table in 
                    if isPres then termMatch else term
  | Const _ -> term 
  | Atomic (constPred,term_list) -> Atomic(constPred,List.map (subst table) term_list)

let rec substClause table clause = 
  match clause with 
  | head,noTermsList ->  
        let newHead =(subst table (atomToTerm head)) in 
        let newTermsList = List.map (subst table) noTermsList in 
          newHead,newTermsList

let composeTables tbl1 tbl2 = 
  let rec composeTableHlpr tbl1 tbl2 curTbl = match tbl1 with
  | (var,term)::tbl1Rem -> let termAftSub = subst tbl2 term in 
                            composeTableHlpr tbl1Rem tbl2 ((var,termAftSub)::curTbl)
  | [] -> curTbl
  in
    composeTableHlpr tbl1 tbl2 tbl2 

(*
  first term should be from the question
  and term2 from the rule with all the 
  temporary variables and what not
*)
exception NotUnifiable of term*term
exception PredicateLengthDoesntMatch
let rec unifyTerms term1 term2 = 
  match term1,term2 with 
  | Var var1,term2 -> [(var1,term2)]
  | term1,Var var1 -> unifyTerms term2 term1 
  | Atomic (pred1,termLst1),Atomic (pred2,termLst2) -> 
    if pred1 <> pred2 then 
      (raise (NotUnifiable (term1,term2)))
    else
      (let idenitySub = [] in 
        try
          termUnifyHelper termLst1 termLst2 idenitySub
        with
        | PredicateLengthDoesntMatch -> (raise (NotUnifiable (term1,term2)))
      )
  | Const const1,Const const2 -> if const1 = const2 then [] else (raise (NotUnifiable (term1,term2)))
  | _,_ -> (raise (NotUnifiable (term1,term2)))
and termUnifyHelper termLst1 termLst2 curUnf = 
  match termLst1,termLst2 with 
  | [],[]                   -> curUnf
  | [],term1::rem           -> raise PredicateLengthDoesntMatch
  | term1::rem,[]           -> raise PredicateLengthDoesntMatch
  | term1::rem1,term2::rem2 -> let newTerm1 = subst curUnf term1 in 
                               let newTerm2 = subst curUnf term2 in 
                                  let additionalUnf = unifyTerms newTerm1 newTerm2 in 
                                  let newCurUnf = composeTables curUnf additionalUnf in 
                                    termUnifyHelper rem1 rem2 newCurUnf

let lstToPred lstData = 
  let termList,termOption = lstData in 
    let rec lstToPredHelper termList basePred = 
      match termList with
      | [] -> basePred
      | x::rem -> Atomic ("!lst",[x;lstToPredHelper rem basePred])
    in 
    let basePred = 
    (  match termOption with
      | None -> Const "!empty"
      | Some term -> term
    ) in 
      lstToPredHelper termList basePred

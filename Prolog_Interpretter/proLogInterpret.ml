open ParserTypes;;
open ParserPrint;;
open Util;;
exception HeadTailOfEmpty
let lstEmpty lst = 
  match lst with 
  | [] -> true 
  | _::_ -> false
let hd lst = 
  match lst with 
| x::rem -> x
| [] -> raise HeadTailOfEmpty
let tl lst = 
  match lst with
| x::rem -> rem 
| [] -> raise HeadTailOfEmpty
let rec length lst = match lst with 
| [] -> 0
| x::rem -> 1 + (length rem)
let lstToArr lst defaultElm = 
  let lstLen = length lst in 
  let resultArr = Array.make lstLen defaultElm in 
  let rec convertArr curIndx curLst arr = match curLst with
    | [] -> arr 
    | cur::rem -> (arr.(curIndx) <- cur);convertArr (curIndx+1) rem arr 
  in
    convertArr 0 lst resultArr
let arrToLst arr = 
  let rec arrToLstHelper curIndx curLst arr =
    if curIndx >= 0 then 
      let curElm = arr.(curIndx) in 
        arrToLstHelper (curIndx-1) (curElm::curLst) arr
    else
      curLst
  in
    arrToLstHelper ((Array.length arr) - 1) [] arr 
let rec removeElms noElms stk = 
  if noElms = 0 then 
    stk
  else 
    removeElms (noElms-1) (tl stk)

let translateClause clause = 
  let varsLst = varsClause clause [] in 
  let mapFunc indx = Var(TempVar indx) in
  let varsLstWithIndx = lstToLstIndx varsLst mapFunc in 
  let noVars = length varsLstWithIndx in
    match clause with
    | head,atomLst -> 
        let head = atomToTerm head in
        let substFunc term = subst varsLstWithIndx term in
        let termLst = List.map atomToTerm atomLst in
            ((termToAtom (substFunc head)),(List.map termToAtom (List.map substFunc termLst))),noVars
let translateClauseArr clauseArr = List.map translateClause clauseArr 

let getInstantiatedRule ruleArr indx varNoLeft = 
  let curRule,noVars = ruleArr.(indx) in 
  (*rename variables so that they do not conflict*)
  let varRemapFunc indx = 
    let oldVar = TempVar indx in 
    let newVar = Var(TempVar (indx+varNoLeft)) in 
      (oldVar,newVar) 
  in
    let substTable = List.init noVars varRemapFunc in
    let newClause = substClause substTable curRule in 
      (newClause,noVars+varNoLeft)

let rec tryUnifyWithRule curAtomFrame curRuleHead curUnif = 
  match curAtomFrame with
  | atomic_formula,indx -> 
      let new_atomic = subst curUnif atomic_formula in 
          let additionalUnif = unifyTerms new_atomic curRuleHead in 
          let newUnif = composeTables curUnif additionalUnif in 
            (newUnif,new_atomic,indx+1)


type evaluateStack = atomic_formula*int*int 
type curFrame = atomic_formula option
type goalStk =  atomic_formula list 
type unifierStk = substTable list

type result = B of bool | Unif of substTable
(*temporary print functions*)
let rec sprintUnifyTable tbl = match tbl with
| [] -> Printf.sprintf "\n"
| (var,term)::rem -> Printf.sprintf "%s = %s\n%s" (sprintVar var) (sprintTerm term) (sprintUnifyTable rem)
let printUnifyTable tbl = Printf.printf "%s" (sprintUnifyTable tbl)

let findNextPossibility curStateAndVar =
  let curState,varArr = curStateAndVar in  
  let evaluatedStk,curFrame,goalStk,unifierStk,varIndx,ruleArr = curState in 
  let newCurFrame = None in 
  let newEvaluatedSTack = tl evaluatedStk in 
  let lastEval = hd evaluatedStk in 
  let atom,ruleIndx,noSubGoal = lastEval in
  let newGoalStk = [(atom,ruleIndx)]@goalStk in 
  let unifierStk = tl unifierStk in 
      (newEvaluatedSTack,newCurFrame,newGoalStk,unifierStk,varIndx,ruleArr),varArr

(*interpret evaluatedStk curFrame goalStk unifierStack varIndx ruleArr*)
let rec interpret 
  evaluatedStk curFrame goalStk unifierStack varIndx ruleArr = 
  let curState = evaluatedStk,curFrame,goalStk,unifierStack,varIndx,ruleArr in
  match curFrame with 
  | None -> 
      if lstEmpty goalStk then 
        ((*Printf.printf "GoalStk is empty\n";*)if lstEmpty unifierStack then 
          ((*Printf.printf "Unifier Stack is empty\n";*)(curState,B false))
        else
          ((*Printf.printf "Unifier Stack non empty returning result\n";*)(curState,Unif (hd unifierStack))))
      else
        let curFrame = hd goalStk in
        let cAtm,rNo = curFrame in 
        let goalStk = tl goalStk in 
          ((*Printf.printf "goal stk non empty passing in argument %s,%d\n" (sprintTerm cAtm) (rNo);*)interpret evaluatedStk (Some curFrame) goalStk unifierStack varIndx ruleArr)
  | Some (atomic_formula,ruleIndx) -> 
    let ruleArrLength = Array.length ruleArr in
    (*Printf.printf "Entered some branch curAtomFrame non empty\n";*)
    if ruleIndx < ruleArrLength then
      let curRule,newVarIndx = getInstantiatedRule ruleArr ruleIndx varIndx in 
      let curHead,curBody = curRule in 
      (*Printf.printf "Trying to unify with %s :- %s\n" (sprintTerm curHead) (sprintTermList curBody);*)
      let curUnif = hd unifierStack in 
      try
        let newUnif,newAtmoic,newRuleIndx = tryUnifyWithRule (atomic_formula,ruleIndx) curHead curUnif in 
        let numSubGoals = length curBody in
        let evaluatedStk = (atomic_formula,newRuleIndx,numSubGoals)::evaluatedStk in 
        let curFrame = None in 
        let goalStk = (List.map (fun x-> (x,0)) curBody)@goalStk in 
        let unifierStack = newUnif::unifierStack in
          (*Printf.printf "Able to unify with head newUnif is:\n";printUnifyTable newUnif;*)interpret evaluatedStk curFrame goalStk unifierStack newVarIndx ruleArr
      with (NotUnifiable (_,_)) -> 
          (*Printf.printf "Unable to unify with head incrementing ruleIndx \n";*)interpret evaluatedStk (Some (atomic_formula,ruleIndx+1)) goalStk unifierStack newVarIndx ruleArr
    else 
      ((*Printf.printf "ruleIndx out of range backtarck\n";*)
      if lstEmpty evaluatedStk then 
        ((*Printf.printf "No previous evalution to back track to\n";*)(curState,B false))
      else
        let goalStk = (atomic_formula,0)::goalStk in 
        let lastAtomicFormula,ruleIndx,numGoalsToRemove = hd evaluatedStk in 
        let evaluatedStk = tl evaluatedStk in 
        let goalStk= removeElms numGoalsToRemove goalStk in 
        let unifierStack = tl unifierStack in 
          (*Printf.printf "Found previous evaluated and using that";*)interpret evaluatedStk (Some (lastAtomicFormula,ruleIndx)) goalStk unifierStack varIndx ruleArr)

let printVarAnswer var curUnif = 
  let term = lookup var curUnif in 
    Printf.printf "%s = %s\n" (sprintVar var) (sprintTerm term)

let printAnswer varArr curUnif = 
let rec printAnswerHelper varArr curUnif = 
  match varArr with 
  | [] -> ()
  | curVar::rem -> printVarAnswer curVar curUnif;printAnswerHelper rem curUnif
in 
  Printf.printf "true\n";printAnswerHelper varArr curUnif
let progLstToArr progLst = 
  let defualtHead = "!",[] in
  let defaultClause = defualtHead,[] in 
  let defaultClauseTrans = defaultClause,0 in 
    lstToArr progLst defaultClauseTrans

let convertClauseAtomicToTerm clause = 
  match clause with 
  | (clauseHead,clauseBody),ruleIndx ->
      let clauseBody = List.map (fun x -> (Atomic x)) clauseBody in 
        (clauseHead,clauseBody),ruleIndx
(*interpret evaluatedStk curFrame goalStk unifierStack varIndx ruleArr*)
(*
let rec sprintGoalListWithRuleIndx goalLstWithRuleIndx = 
  match goalLstWithRuleIndx with
  | [] -> Printf.sprintf ""
  | (term,indx)::rem -> Printf.sprintf "(%s,%d),%s" (sprintTerm term) indx (sprintGoalListWithRuleIndx rem)
*)
let solveGoal goalLst ruleLst startStateOption= 
  match startStateOption with
  | Some startStateAndVar ->
    let startState,varArr = startStateAndVar in 
    let evaluatedStk,curFrame,goalStk,unifierStk,varIndx,ruleArr = startState in 
      let nextState,unifierOrBool = interpret evaluatedStk curFrame goalStk unifierStk varIndx ruleArr in 
      (
        match unifierOrBool with
        | B b -> Printf.printf "false\n";((nextState,varArr),false)
        | Unif curUnif -> printAnswer varArr curUnif;((nextState,varArr),true)
      )
  | None ->
      let ruleLst = List.map convertClauseAtomicToTerm ruleLst in 
      let ruleArr = progLstToArr ruleLst in 
      let varArr = varsAtomicList goalLst [] in
      (*writing atomic here shouldnt be strictly necessary try checking that out later*)
      let goalLstWithRuleIndx = List.map (fun x -> (Atomic x,0)) goalLst in 
        let curState,unifierOrBool = interpret [] None goalLstWithRuleIndx [[]] 0 ruleArr in 
        (
          match unifierOrBool with
          | B b -> Printf.printf "false\n";((curState,varArr),false)
          | Unif curUnif -> printAnswer varArr curUnif;((curState,varArr),true)
        )
      
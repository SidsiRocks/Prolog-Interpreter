open ParserTypes;;

let sprintVar var = match var with
| TempVar varNum -> Printf.sprintf "!%d" varNum
| NormalVar varTxt -> varTxt

let sprintConstPred pred = pred 

let rec sprintTerm term = match term with
| Atomic atomic_formula -> sprintAtomicFor atomic_formula
| Var var -> sprintVar var
| Const const -> sprintConstPred const 
and sprintAtomicFor atomicFor = match atomicFor with 
| constPred,termLst -> Printf.sprintf "%s(%s)" (sprintConstPred constPred) (sprintTermList termLst)
and sprintTermList termLst = 
    let rec sprintTermListHelper termLst = match termLst with
    | [] -> Printf.sprintf ""
    | term::termLst ->(let termTxt = sprintTerm term in 
                          Printf.sprintf ",%s%s" termTxt (sprintTermListHelper termLst)
                      )
    in
      match termLst with
      | [] -> Printf.sprintf ""
      | term::rem -> Printf.sprintf "%s%s" (sprintTerm term) (sprintTermListHelper rem)

let atomToTerm atom = Atomic atom
let sprintHead = sprintAtomicFor
let sprintClause clause = match clause with
| head,atomic_formula_list -> Printf.sprintf "%s :- %s" (sprintHead head) (sprintTermList (List.map atomToTerm atomic_formula_list))
let rec sprintClauseList clsList = match clsList with 
| [] -> Printf.sprintf "\n"
| cls::rem -> Printf.sprintf "%s;\n%s" (sprintClause cls) (sprintClauseList rem)
let sprintProg clsAndNoVarsLst = 
  let clsList = List.map (fun tpl -> let x,y=tpl in x) clsAndNoVarsLst in 
    sprintClauseList clsList
let sprintAtomicForLst atomicFormLst =
    let rec sprintAtomicForLstHelper atomicFormLst = match atomicFormLst with 
    | [] -> Printf.sprintf ""
    | atom::atomLst ->(let atomTxt = sprintAtomicFor atom in 
                        Printf.sprintf ",%s%s" atomTxt (sprintAtomicForLstHelper atomLst)) 
in 
  match atomicFormLst with 
  | [] -> Printf.sprintf ""
  | atom::rem -> Printf.sprintf "%s%s" (sprintAtomicFor atom) (sprintAtomicForLstHelper rem)

let sprintGoal = sprintAtomicForLst
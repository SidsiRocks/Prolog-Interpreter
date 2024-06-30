altParser:
	ocamlc -c util.ml
	ocamlc -c dataTypes.ml
	ocamlc -c parserTypes.ml
	ocamlyacc proLogParse.mly
	ocamlc -c proLogParse.mli 
	ocamlc -c proLogParse.ml 
	ocamlc -c printFunc.ml 
	ocamllex proLogLex.mll 
	ocamlc -c proLogLex.ml
	ocamlc -c parserPrint.ml
	ocamlc -c proLogInterpret.ml
	ocamlc -c altParserMain.ml 
	ocamlc -o altParserBuild util.cmo dataTypes.cmo parserTypes.cmo printFunc.cmo proLogLex.cmo proLogParse.cmo parserPrint.cmo proLogInterpret.cmo altParserMain.cmo
parser:
	ocamlc -c util.ml
	ocamlc -c dataTypes.ml
	ocamlc -c parserTypes.ml
	ocamlyacc proLogParse.mly
	ocamlc -c proLogParse.mli 
	ocamlc -c proLogParse.ml 
	ocamlc -c printFunc.ml 
	ocamllex proLogLex.mll 
	ocamlc -c proLogLex.ml
	ocamlc -c parserPrint.ml
	ocamlc -c proLogInterpret.ml
	ocamlc -c parserMain.ml 
	ocamlc -o parserBuild util.cmo dataTypes.cmo parserTypes.cmo printFunc.cmo proLogLex.cmo proLogParse.cmo parserPrint.cmo proLogInterpret.cmo parserMain.cmo
lexer:
	ocamlyacc proLogParse.mly 
	ocamlc -c proLogParse.mli
	ocamllex proLogLex.mll
	ocamlc -c dataTypes.ml
	 
	ocamlc -c printFunc.ml
	ocamlc -c proLogLex.ml
	ocamlc -c lexerMain.ml
	ocamlc -o lexerBuild dataTypes.cmo printFunc.cmo proLogLex.cmo lexerMain.cmo
cleanCmi:
	rm -f ./dataTypes.cmi
	rm -f ./lexerMain.cmi
	rm -f ./printFunc.cmi 
	rm -f ./proLogLex.cmi 
	rm -f ./proLogLex.ml
	rm -f ./parserMain.cmi 
	rm -f ./parserTypes.cmi 
	rm -f ./proLogParse.cmi 
	rm -f ./proLogParse.ml 
	rm -f ./proLogParse.mli 
	rm -f ./parserPrint.cmi 
	rm -f ./proLogInterpret.cmi 
	rm -f ./util.cmi
cleanCmo:
	rm -f ./dataTypes.cmo 
	rm -f ./lexerMain.cmo 
	rm -f ./printFunc.cmo
	rm -f ./proLogLex.cmo 
	rm -f ./parserMain.cmo 
	rm -f ./parserTypes.cmo 
	rm -f ./proLogParse.cmo 
	rm -f ./parserPrint.cmo
	rm -f ./proLogInterpret.cmo
	rm -f ./util.cmo

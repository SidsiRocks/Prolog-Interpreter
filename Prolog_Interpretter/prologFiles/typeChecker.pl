:- use_module(library(lists)).
/*few of the testcases used
    (Assumed everywhere that G of the form (varName,type) but varaiables
    in expression of the form varT(varName) useful in type-checking during 
    assignment operator.)
    
    hastype(G,not(varT(x)),boolT),hasType(G,add(varT(x),varT(y)),intT).
        evaluates to false no type assignment to variables can work
    
    checking if float and int works together
    hastype([(y,intT)|Rem],add(intT(1),add(varT(x),varT(y))),floatT).
        evaluates to Rem = [(x,floatT)] as expected
    hastype([(x,intT),(y,intT)],add(varT(x),varT(y)),floatT).
        evaluates to true as int can be interpretted as float
    
*/
/*assuming that integer,boolean,string and character constants are
  wrapped in the following constructors*/
hastype(_,intT(_),intT) :- !.
hastype(_,boolT(_),boolT) :- !.
hastype(_,floatT(_),floatT).
hastype(_,intT(_),floatT).
hastype(_,strT(_),strT) :- !.
hastype(_,charT(_),charT):- !.
/*
added special case for intT being interpretted as floatT 
floatT is superset of intT
*/
/*consider both alternatives*/
notEq(X,X) :- fail.
notEq(X,_).

/*defining floats to be a superset of ints*/
/*numeric operations and ints and floats*/
hastype(G,add(E1,E2),intT) :- hastype(G,E1,intT),hastype(G,E2,intT),!.
hastype(G,mul(E1,E2),intT) :- hastype(G,E1,intT),hastype(G,E2,intT),!.
hastype(G,sub(E1,E2),intT) :- hastype(G,E1,intT),hastype(G,E2,intT),!.
hastype(G,div(E1,E2),intT) :- hastype(G,E1,intT),hastype(G,E2,intT),!.
hastype(G,mod(E1,E2),intT) :- hastype(G,E1,intT),hastype(G,E2,intT),!.

hastype(G,add(E1,E2),floatT) :- hastype(G,E1,floatT),hastype(G,E2,floatT).
hastype(G,mul(E1,E2),floatT) :- hastype(G,E1,floatT),hastype(G,E2,floatT).
hastype(G,sub(E1,E2),floatT) :- hastype(G,E1,floatT),hastype(G,E2,floatT).
hastype(G,div(E1,E2),floatT) :- hastype(G,E1,floatT),hastype(G,E2,floatT).
hastype(G,mod(E1,E2),floatT) :- hastype(G,E1,floatT),hastype(G,E2,floatT).

hastype([(X,T)|_],varT(X),T) :- !.
/*another rule to handle intT being subset of floatT*/
hastype([(X,intT)|_],varT(X),floatT) :- !.
hastype([(X,T2)|_],varT(X),T) :- notEq(T2,T),!,fail.
hastype([(_,_)|Rem],X,T) :- hastype(Rem,X,T).

/*logical operations on bools*/
hastype(G,not(E1),boolT) :- hastype(G,E1,boolT).
hastype(G,and(E1,E2),boolT) :- hastype(G,E1,boolT),hastype(G,E2,boolT).
hastype(G,or(E1,E2),boolT) :- hastype(G,E1,boolT),hastype(G,E2,boolT).
hastype(G,xor(E1,E2),boolT) :- hastype(G,E1,boolT),hastype(G,E2,boolT).

/*append operations on strings and characters similar to c++*/
hastype(G,append(E1,E2),strT) :- hastype(G,E1,strT),hastype(G,E2,strT).
hastype(G,append(E1,E2),strT) :- hastype(G,E1,strT),hastype(G,E2,charT).
hastype(G,append(E1,E2),strT) :- hastype(G,E1,charT),hastype(G,E2,strT).
/*may want to add other symmetric operation*/

/*ensuring assignment operator fails for constants since there is no separate wrapper for variables
hastype(G,asgn(intT(X),E1),unitT) :- fail.
hastype(G,asgn(charT(X),E1),unitT) :- fail.
hastype(G,asgn(strT(X),E1),unitT) :- fail.
hastype(G,asgn(floatT(X),E1),unitT) :- fail.
hastype(G,asgn(boolT(X),E1),unitT) :- fail.
hastype(G,asgn(X,E1),unitT) :- hastype(G,X,T),hastype(G,E1,T).*/
hastype(G,asgn(varT(X),E1),unitT) :- hastype(G,varT(X),T),hastype(G,E1,T).

/*comparison operators for floats and ints*/
hastype(G,eq(E1,E2),boolT) :- hastype(G,E1,T),hastype(G,E2,T).
hastype(G,grt(E1,E2),boolT) :- hastype(G,E1,intT),hastype(G,E2,intT).
hastype(G,grt(E1,E2),boolT) :- hastype(G,E1,floatT),hastype(G,E2,floatT).
hastype(G,grtEq(E1,E2),boolT) :- hastype(G,E1,intT),hastype(G,E2,intT).
hastype(G,grtEq(E1,E2),boolT) :- hastype(G,E1,floatT),hastype(G,E2,floatT).
hastype(G,less(E1,E2),boolT) :- hastype(G,E1,intT),hastype(G,E2,intT).
hastype(G,less(E1,E2),boolT) :- hastype(G,E1,floatT),hastype(G,E2,floatT).
hastype(G,lessEq(E1,E2),boolT) :- hastype(G,E1,intT),hastype(G,E2,intT).
hastype(G,lessEq(E1,E2),boolT) :- hastype(G,E1,floatT),hastype(G,E2,floatT).

/**comparison for strings and chars*/
hastype(G,grt(E1,E2),boolT) :- hastype(G,E1,strT),hastype(G,E2,strT).
hastype(G,grtEq(E1,E2),boolT) :- hastype(G,E1,strT),hastype(G,E2,strT).
hastype(G,less(E1,E2),boolT) :- hastype(G,E1,strT),hastype(G,E2,strT).
hastype(G,lessEq(E1,E2),boolT) :- hastype(G,E1,strT),hastype(G,E2,strT).
hastype(G,grt(E1,E2),boolT) :- hastype(G,E1,charT),hastype(G,E2,charT).
hastype(G,grtEq(E1,E2),boolT) :- hastype(G,E1,charT),hastype(G,E2,charT).
hastype(G,less(E1,E2),boolT) :- hastype(G,E1,charT),hastype(G,E2,charT).
hastype(G,lessEq(E1,E2),boolT) :- hastype(G,E1,charT),hastype(G,E2,charT).

/*checks for variables have to be placed at the end so that they do not affect the others
hastype([(X,T)|_],X,T) :- !.
hastype([(X,intT)|_],X,floatT) :- !.
hastype([(X,T2)|_],X,T) :- notEq(T2,T),!,fail.
hastype([(_,_)|Rem],X,T) :- hastype(Rem,X,T).*/

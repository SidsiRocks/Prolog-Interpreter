:- use_module(library(lists)).

/*Doesn't work with deleting permuations of lists i.e del([1,2,3],[[3,2,1]],X) wouldn't work*/
del(_,[],[]):- !.
del(X,[X|R],Z):- del(X,R,Z),!.
del(X,[Y|R],[Y|Z]):- del(X,R,Z),!.

/*Similar to delete doesn't work with permutation of lists*/
remdups([],[]):- !.
remdups([X|R],[X|Z]):- del(X,R,L),remdups(L,Z),!.

/*Doesn't work with permuation of lists*/
unionl([],S2,S2):- !.
unionl(S1,[],S1):- !.
unionl([X|R],S2,[X|Z]) :- del(X,S2,S3),unionl(R,S3,Z).

/*changed append's name to aend for compatibility with gprolog interpreter*/
aend([],L,L):-!.
aend([X|R],L,[X|Z]) :- aend(R,L,Z).

/*removed ! from mem function so that all members of list are considered in rflxTransCls function*/
mem(X,[X|_]).
mem(X,[_|Tail]) :-mem(X,Tail).
/*defining membership for symmetric set*/
mem((X,Y),symm(R)) :- mem((X,Y),R).
mem((X,Y),symm(R)) :- mem((Y,X),R). 
/*first two self explanatory*/
/*third rule recursively calss rflxTransCls but reduces the size of the set each iteration so that it can terminate in finite time*/
/*this doesn't invalidate correctness as if there is a path in relation digraph connecting a and b then vertices will not repeat*/
/*in the shortest path*/
mem((X,X),rflxTransCls(_,S)) :- mem(X,S),!.
mem((X,Y),rflxTransCls(R,_)) :- mem((X,Y),R),!.
mem((X,Y),rflxTransCls(R,S)) :- mem(Z,S),mem((X,Z),R),del(X,S,S1),
                           mem((Z,Y),rflxTransCls(R,S1)),!.
/*rflxTransSymm closure obtained by transitive and reflexive closure over symmetric set*/
mem((X,Y),rflxTransSymm(R,S)) :- mem((X,Y),rflxTransCls(symm(R),S)).

/*like union subset relation doesn't work with permutation of lists*/
subset([],_) :- !.
subset([X|S2],S1) :- mem(X,S1),subset(S2,S1).
eqset(S1,S2) :- subset(S1,S2),subset(S2,S1).
/*similar to the member function here checks if set L1 belongs to a powerset permuations also work here*/
setmem(L1,[X|_]) :- eqset(X,L1). 
setmem(L1,[_|Tail]) :- setmem(L1,Tail).

/*mapcons(X,L1, L2) --  cons the element X to each list in L1 to get L2 */
mapcons(_,[],[]) :- !.
mapcons(X,[Y|R],[ [X|Y] | Z]) :- mapcons(X,R,Z).


/* powerI( S, P1): Here is an implementation of powerset of S */
powerl([],[[]]) :- !.
powerl([X|R],P) :- powerl(R,P1),mapcons(X,P1,P2),aend(P2,P1,P),!.
/*powerlsub(P1,P2) :- checks if power set P1 is a subset of power set P2 works with permutations of lists*/
powerlsub([],_) :- !.
powerlsub([X|Tail],P2) :- setmem(X,P2),powerlsub(Tail,P2),!.
/*powerleq(P1,P2) :- checks if two power sets equal*/
powerleq(P1,P2) :- powerlsub(P1,P2),powerlsub(P2,P1),!.

/*interl(S1,S2,S3)     :- finding intersection of S1,S2*/
interl([],_,[]) :- !.
interl(_,[],[]) :- !.
interl([X|R],L1,[X|Tail]) :- mem(X,L1),del(X,L1,L2),interl(R,L2,Tail),!.
interl([_|R],L1,Tail) :- interl(R,L1,Tail).

/*diffl(S1,S2,S2)      :- finds difference S1-S2 and sets it in S3*/
diffl([],_,[]) :- !.
diffl(S1,[],S1) :- !.
diffl([X|R],L1,[X|Tail]) :- \+mem(X,L1),diffl(R,L1,Tail),!.
diffl([_|R],L1,Tail) :- diffl(R,L1,Tail).


/*singlecartl(X,L1,L2) :- returns product of set {X} X L1 in L2.*/
singlecartl(_,[],[]) :- !.
singlecartl(X,[Y|Tail],[(X,Y)|L1]) :- singlecartl(X,Tail,L1),!.

/*cartesianl(S1,S2,S3) :- finds cartesian product of S1 X S2 set in S3*/
cartesianl([],_,[]) :- !.
cartesianl([X|R],Tail,L) :- singlecartl(X,Tail,L1),cartesianl(R,Tail,L2)
,aend(L1,L2,L),!.


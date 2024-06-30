:- use_module(library(lists)).
/*
    Usage of new defined functions
    append() replaced with aend() for compatibility with gprolog
    
    --Relations asked in assignment
    interl(S1,S2,S3)     :- finding intersection of S1,S2 store one representation in S3
    diffl(S1,S2,S3)      :- finding difference of sets S1-S2 store one representation of this in S3

    cartesianl(S1,S2,S3) :- finds cartesian product of S1 X S2 store one representation in S3
    powerleq(P1,P2)      :- returns true if both power sets P1,P2 are equivalent assuming no set of sets
    rflxTransCls(R,S)    :- reflexive transitive closure of relation R over set S defined through membership
                            mem((X,Y),rflxTransCls(R,S)) also assumes relations not between set of sets
    rlfxTransSymm(R,S)   :- reflexive transitive symmetric closure of a relation R over set S defined through membership
                            mem((X,Y),rflxTransSymm(R,S)) assumes relations not between set of sets
    --Explanation of powerleq
    powerleq(P1,P2) implemented with the help of powerlsub(P1,P2) just like we would for normal set equality to implement
    powerlsub(P1,P2) implemented as powerlsub([X|Tail],P2) :- setmem(X,P2),powerlsub(Tail,P2)
    setmem(X,P2) is a helper function return to check if the set X (As every member of the power set would be a set itself)
    setmem(X,[Y|Tail]) can be implemented by checking if any element of P2 is equal to X using eqset(X,Y) this takes care of 
    different permutation of sets in their list representations.

    --Helper relations
    subset(S1,S2)        :- returns true if S1 subset of S2.
    eqset(S1,S2)         :- returns true if S1 eqaul to S2.
    setmem(L1,P1)        :- returns true if set L1 is a member of set of sets P1.
    powerlsub(P1,P2)     :- returns true if power set P1 is a subset of power set P2 used for powerleq(P1,P2).
    singlecartl(X,L1,L2) :- returns product of set {X} X L1 in L2.

    --TestCases used (testcases with reasoning for choosing cases presented in separate section below)
    unionl([1,2,5],[6,7,12,14,90],X).
    unionl([1,2,17,23,5],[2,6,8,1,17],X).
    unionl([1,2,17,23,5],[2,6,5,23,8,1,17],X).
    unionl([2,6,5,23,8,1,17],[1,2,17,23,5],X).
    unionl([],[1,2,3,4,5],X).
    unionl([1,2,3,4,5],[],X).
    unionl([],[],X).

    powerl([],X).
    powerl([1,2,3],P1).
    powerl([1,3,2],P2).
    powerl([1,2,3,4,5],X).

    interl([1,2,3],[4,5,6,7],X).
    interl([1,2,17,23,5],[2,6,8,1,17],X).
    interl([2,6,8,1,17],[1,2,17,23,5],X).
    interl([1,2,17,23,5],[2,6,5,23,8,1,17],X).
    interl([2,6,5,23,8,1,17],[1,2,17,23,5],X).
    interl([1,2,3],[],X).
    interl([],[1,2,3],X).

    diffl([1,2,3],[4,5,6,7],X).
    diffl([4,5,6,7],[1,2,3],X).
    diffl([1,2,17,23,5],[2,6,8,1,17],X).
    diffl([2,6,8,1,17],[1,2,17,23,5],X).
    diffl([1,2,17,23,5],[2,6,5,23,8,1,17],X).
    diffl([2,6,5,23,8,1,17],[1,2,17,23,5],X).
    diffl([],[1,2,3],X).
    diffl([1,2,3],[],X).

    cartesianl([],[1,2,3],X).
    cartesianl([1,2,3],[],X).
    cartesianl([],[],X).
    cartesianl([2,3,4,1],[1],X).
    cartesianl([1,2,3,4],[2,6,7,12,4],X).

    powerl([],P1),powerl([],P2),powereq(P1,P2).
    powerl([1,2,3],P1),powerl([3,1,2],P2),powereq(P1,P2).
    powerl([1,2,3,4,5],P1),powerl([3,1,2],P2),powerleq(P1,P2).
    powerl([1,2,3],P1),powerl([3,1,2,4,5],P2),powerleq(P1,P2).
    powerl([1,2,17,23,5],P1),powerl([2,6,5,23,8,1],P2),powerleq(P1,P2).

    mem((1,3),rflxTransCls([(1,2),(2,3)],[1,2,3])).
    mem((1,1),rflxTransCls([(1,2),(2,3)],[1,2,3])).
    mem((3,3),rflxTransCls([(1,2),(1,3),(3,5),(5,2),(2,4),(5,4)],[1,2,3,4,5])).
    mem((2,4),rflxTransCls([(1,2),(2,3)],[1,2,3,4])).
    mem((2,4),rflxTransCls([(1,2),(2,3)],[1,2,3])).
    mem((1,4),rflxTransCls([(1,2),(1,3),(3,5),(5,2),(2,4),(5,4)],[1,2,3,4,5])). 
    mem((2,4),rflxTransCls([(1,2),(1,3),(3,5),(5,2),(2,4),(5,4),(2,5),(3,1)],[1,2,3,4,5])).
    mem((6,9),rflxTransCls([(1,2),(1,3),(3,5),(5,2),(2,4),(5,4),(6,7),(6,8),(7,9),(8,9),(9,10),(9,11)],[1,2,3,4,5,6,7,8,9,10,11])).
    mem((1,6),rflxTransCls([(1,2),(1,3),(3,5),(5,2),(2,4),(5,4),(6,7),(6,8),(7,9),(8,9),(9,10),(9,11)],[1,2,3,4,5,6,7,8,9,10,11])).

    mem((2,3),rflxTransSymm([(1,2),(1,3)],[1,2,3])).
    mem((3,3),rflxTransSymm([(1,2),(1,3)],[1,2,3,4])).
    mem((3,11),rflxTransSymm([(1,3),(2,3),(3,4),(5,4),(5,8),(9,5),(6,5),(6,7),(7,10),(11,10)],[1,2,3,4,5,6,7,8,9,10,11])).
    mem((2,6),rflxTransSymm([(1,2),(1,3),(4,1),(3,4),(4,2),(4,5),(6,5),(5,7),(8,9),(8,10),(10,9)],[1,2,3,4,5,6,7,8,9,10,11])).
    mem((11,9),rflxTransSymm([(1,2),(1,3),(4,1),(3,4),(4,2),(4,5),(6,5),(5,7),(8,9),(8,10),(10,9),(10,11)],[1,2,3,4,5,6,7,8,9,10,11])).
    mem((4,8),rflxTransSymm([(1,2),(1,3),(4,1),(3,4),(4,2),(4,5),(6,5),(5,7),(8,9),(8,10),(10,9),(10,11)],[1,2,3,4,5,6,7,8,9,10,11])).
    mem((6,1),rflxTransSymm([(1,2),(1,3),(4,1),(3,4),(4,2),(4,5),(6,5),(5,7)],[1,2,3,4,5,6,7])).

    --Testcases used with reasoning and output
    --test cases for unionl
    --basic test case with disjoint sets
    unionl([1,2,5],[6,7,12,14,90],X).
    X = [1,2,5,6,7,12,14,90]
    --test cases with sets having some common elements
    --no duplicates in the result
    unionl([1,2,17,23,5],[2,6,8,1,17],X).
    X = [1,2,17,23,5,6,8]
    --one set subset of another
    --no duplicates in the result
    unionl([1,2,17,23,5],[2,6,5,23,8,1,17],X).
    X = [1,2,17,23,5,6,8]
    unionl([2,6,5,23,8,1,17],[1,2,17,23,5],X).
    X = [2,6,5,23,8,1,17]
    --one set empty set
    unionl([],[1,2,3,4,5],X).
    X = [1,2,3,4,5]
    unionl([1,2,3,4,5],[],X).
    X = [1,2,3,4,5]
    --both empty set 
    unionl([],[],X).
    X = []


    --test cases for powerl
    --basic testcase with empty set 
    powerl([],X).
    X = [[]]
    --testcase with two different ordering with two sets 
    powerl([1,2,3],P1).
    P1 = [[1,2,3],[1,2],[1,3],[1],[2,3],[2],[3],[]]
    powerl([1,3,2],P2).
    P2 = [[1,3,2],[1,3],[1,2],[1],[3,2],[3],[2],[]]
    --testcase with larger set size
    powerl([1,2,3,4,5],X).
    X = [[1,2,3,4,5],[1,2,3,4],[1,2,3,5],[1,2,3],[1,2,4,5]
        ,[1,2,4],[1,2,5],[1,2],[1,3,4,5],[1,3,4],[1,3,5],
        [1,3],[1,4,5],[1,4],[1,5],[1],[2,3,4,5],[2,3,4],
        [2,3,5],[2,3],[2,4,5],[2,4],[2,5],[2],[3,4,5],
        [3,4],[3,5],[3],[4,5],[4],[5],[]]


    --test cases for interl
    --basic intersection with disjoint subsets
    interl([1,2,3],[4,5,6,7],X).
    X = []
    --testcase with non empty intersection 
    interl([1,2,17,23,5],[2,6,8,1,17],X).
    X = [1,2,17]
    interl([2,6,8,1,17],[1,2,17,23,5],X).
    X = [2,1,17]
    --testcase with one subset of another 
    interl([1,2,17,23,5],[2,6,5,23,8,1,17],X).
    X = [1,2,17,23,5]
    interl([2,6,5,23,8,1,17],[1,2,17,23,5],X).
    X = [2,5,23,1,17]
    --testcase with one empty set
    interl([1,2,3],[],X).
    X = []
    interl([],[1,2,3],X).
    X = []

    --testcases for diffl
    --with two disjoint sets
    diffl([1,2,3],[4,5,6,7],X).
    X = [1,2,3]
    diffl([4,5,6,7],[1,2,3],X).
    X = [4,5,6,7]
    --with non empty intersection 
    diffl([1,2,17,23,5],[2,6,8,1,17],X).
    X = [23,5]
    diffl([2,6,8,1,17],[1,2,17,23,5],X).
    X = [6,8]
    --with one subset of another 
    diffl([1,2,17,23,5],[2,6,5,23,8,1,17],X).
    X = []
    diffl([2,6,5,23,8,1,17],[1,2,17,23,5],X).
    X = [6,8]
    --with one empty set 
    diffl([],[1,2,3],X).
    X = []
    diffl([1,2,3],[],X).
    X = [1,2,3]


    --testcase for cartesianl
    cartesianl([],[1,2,3],X).
    X = []
    cartesianl([1,2,3],[],X).
    X = []
    cartesianl([],[],X).
    X = []
    --with singleton
    cartesianl([2,3,4,1],[1],X).
    X = [(2,1),(3,1),(4,1),(1,1)]
    --with two arbritary sets
    cartesianl([1,2,3,4],[2,6,7,12,4],X).
    X = [(1,2),(1,6),(1,7),(1,12),(1,4),
        (2,2),(2,6),(2,7),(2,12),(2,4),(3,2),
        (3,6),(3,7),(3,12),(3,4),(4,2),(4,6),
        (4,7),(4,12),(4,4)]

    --testcase for powereq
    --checking with two empty sets
    powerl([],P1),powerl([],P2),powereq(P1,P2).
    P1 = [[]]
    P2 = [[]]
    --checking with different permutations
    powerl([1,2,3],P1),powerl([3,1,2],P2),powereq(P1,P2).
    P1 = [[1,2,3],[1,2],[1,3],[1],[2,3],[2],[3],[]]
    P2 = [[3,1,2],[3,1],[3,2],[3],[1,2],[1],[2],[]]
    --checking with one subset of the other 
    powerl([1,2,3,4,5],P1),powerl([3,1,2],P2),powerleq(P1,P2).
    --false
    powerl([1,2,3],P1),powerl([3,1,2,4,5],P2),powerleq(P1,P2).
    --false 
    --checking with non empty intersection and difference
    powerl([1,2,17,23,5],P1),powerl([2,6,5,23,8,1],P2),powerleq(P1,P2).
    --adding one more element to second set exceeds the online sim limit.
    --false

    --testcase for reflexive transitive closure
    --simple succesful transitivity example
    mem((1,3),rflxTransCls([(1,2),(2,3)],[1,2,3])).
    --true
    --simple test for reflexive closure 
    mem((1,1),rflxTransCls([(1,2),(2,3)],[1,2,3])).
    --true 
    --another test with element other than first element 
    mem((3,3),rflxTransCls([(1,2),(1,3),(3,5),(5,2),(2,4),(5,4)],[1,2,3,4,5])).
    --true 
    --simple unsuccesful example to check it terminates
    mem((2,4),rflxTransCls([(1,2),(2,3)],[1,2,3,4])).
    --false 
    --checking for invalid output
    mem((2,4),rflxTransCls([(1,2),(2,3)],[1,2,3])).
    --false
    --checking for elements with multiple paths between them
    mem((1,4),rflxTransCls([(1,2),(1,3),(3,5),(5,2),(2,4),(5,4)],[1,2,3,4,5])).
    --true 
    --checking for relation with some symmetric elements 
    mem((2,4),rflxTransCls([(1,2),(1,3),(3,5),(5,2),(2,4),(5,4),(2,5),(3,1)],[1,2,3,4,5])).
    --true 
    --checking for a relation having digraph with multiple components
    mem((6,9),rflxTransCls([(1,2),(1,3),(3,5),(5,2),(2,4),(5,4),(6,7),(6,8),(7,9),(8,9),(9,10),(9,11)],[1,2,3,4,5,6,7,8,9,10,11])).
    --true 
    --unsuccesful example in digraph with two weakly connected components
    mem((1,6),rflxTransCls([(1,2),(1,3),(3,5),(5,2),(2,4),(5,4),(6,7),(6,8),(7,9),(8,9),(9,10),(9,11)],[1,2,3,4,5,6,7,8,9,10,11])).
    --false 

    --testcase for reflexive symmetric transitive closure
    --simple example with one equivalence class 
    mem((2,3),rflxTransSymm([(1,2),(1,3)],[1,2,3])).
    --true 
    --simple test for reflexive closure 
    mem((3,3),rflxTransSymm([(1,2),(1,3)],[1,2,3,4])).
    --true 
    --Test case with path including both forward and backward arrows
    --The path is 3->4<-5<-6->7->10<-11
    mem((3,11),rflxTransSymm([(1,3),(2,3),(3,4),(5,4),(5,8),(9,5),(6,5),(6,7),(7,10),(11,10)],[1,2,3,4,5,6,7,8,9,10,11])).
    --true 
    --Test case with two equivalence classes
    --first equivalence class
    mem((2,6),rflxTransSymm([(1,2),(1,3),(4,1),(3,4),(4,2),(4,5),(6,5),(5,7),(8,9),(8,10),(10,9)],[1,2,3,4,5,6,7,8,9,10,11])).
    --true 
    --second equivalence class 
    mem((11,9),rflxTransSymm([(1,2),(1,3),(4,1),(3,4),(4,2),(4,5),(6,5),(5,7),(8,9),(8,10),(10,9),(10,11)],[1,2,3,4,5,6,7,8,9,10,11])).
    --true 
    --between two equivalence classes 
    mem((4,8),rflxTransSymm([(1,2),(1,3),(4,1),(3,4),(4,2),(4,5),(6,5),(5,7),(8,9),(8,10),(10,9),(10,11)],[1,2,3,4,5,6,7,8,9,10,11])).
    --false 
    --Test case with multiple path between elements 
    mem((6,1),rflxTransSymm([(1,2),(1,3),(4,1),(3,4),(4,2),(4,5),(6,5),(5,7)],[1,2,3,4,5,6,7])).
    --true 

*/
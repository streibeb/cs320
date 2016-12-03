conc(A, [], A).
conc(A, [B|C], [B|D]) :- conc(A, C, D).

qsort([], []).
qsort([H|T], X) :- 
    partition(H, T, SM, LG), 
    qsort(SM, SM1), 
    qsort(LG, LG1),
    conc([H|LG1], SM1, X).

partition(X, [], [], []).
partition(X, [H|T], [H|SM], LG) :- 
    X =< H, 
    partition(X, T, SM, LG).
partition(X, [H|T], SM, [H|LG]) :- 
    partition(X, T, SM, LG).

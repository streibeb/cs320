married(i,w).
married(d,f).
parent(f,i).
parent(w,d).
parent(i,s1).
parent(w,s1).
parent(d,s2).
parent(f,s2).

parent(X,Z) :-
    married(X,Y),
    parent(Y,Z).

grandparent(X,Z) :-
    parent(X,Y),
    parent(Y,Z).

exists(X, [X|T]).
exists(X, [H|T]) :- exists(X, T).

intersection([], X, []).
intersection([H|T1], X, [H|T2]) :- exists(H, X), intersection(T1, X, T2).
intersection([H|T], X, Y) :- intersection(T, X, Y).

union([], X, X).
union([H|T], X, Y) :- exists(H, X), union(T, X, Y).
union([H|T1], X, [H|T2]) :- union(T1, X, T2).

complement([], X, []).
complement([H|T], X, Y) :- exists(H, X), complement(T, X, Y).
complement([H|T1], X, [H|T2]) :- complement(T1, X, T2).

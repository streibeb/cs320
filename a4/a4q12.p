merge([], [], []).
merge([X], [], [X]).
merge([], [Y], [Y]).

merge([H1|T1], [H2|T2], [H1|NL]) :- H1 =< H2, merge(T1, [H2|T2], NL).
merge([H1|T1], [H2|T2], [H2|NL]) :- H1 > H2, merge([H1|T1], T2, NL).

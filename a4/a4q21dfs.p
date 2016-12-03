%DFS
go(Start, Goal) :-
    empty_stack(Empty_been_list),
    stack(Start, Empty_been_list, Been_list),
    path(Start, Goal, Been_list).

path(Goal, Goal, Been_list) :-
    write('solution path is:'), nl,
    write('state(S,M,L)'), nl,
    reverse_print_stack(Been_list).

path(State, Goal, Been_list) :-
    move(State, Next),
    % not(unsafe(Next)),
    not(member_stack(Next, Been_list)),
    stack(Next, Been_list, New_been_list),
    path(Next, Goal, New_been_list), !.

% Reverse prints a stack
reverse_print_stack(S) :-
    empty_stack(S).
reverse_print_stack(S) :-
    stack(E, Rest, S),
    reverse_print_stack(Rest),
    write(E), nl.

% Stack
empty_stack([]).

stack(E, L, [E|L]).

member_stack(X, [X|T]).
member_stack(X, [Y|T]):- member_stack(X, T).


%not operator
not(P):- P, !, fail; true.

% test.
test:- go(state(0,0,8), state(0,4,4)).

%move is an edge of the state space.  Construct a state space

%large --> small
move(state(S,M,L), state(3,M,NL)) :-
    S < 3,
    S + L > 3,
    NL is L - (3 - S).

move(state(S,M,L), state(NS,M,0)) :- 
    S < 3,
    S + L =< 3,
    NS is S + L.

%large --> medium
move(state(S,M,L), state(S,5,NL)) :-
    M < 5,
    M + L > 5,
    NL is L - (5 - M).

move(state(S,M,L), state(S,NM,0)) :-
    M < 5,
    M + L =< 5,
    NM is M + L.

%medium --> small
move(state(S,M,L), state(3,NM,L)) :-
    S < 3,
    S + M > 3,
    NM is M - (3 - S).

move(state(S,M,L), state(NS,0,L)) :-
    S < 3,
    S + M =< 3,
    NS is S + M.

%small --> large
move(state(S,M,L), state(0,M,NL)) :-
    L < 8,
    L + S =< 8,
    NL is L + S.

%small --> medium
move(state(S,M,L), state(NS,5,L)) :-
    M < 5,
    M + S > 5,
    NS is 3 - (5 - M).

move(state(S,M,L), state(0,NM,L)) :-
    M < 5,
    M + S =< 5,
    NM is M + S.

%medium --> large
move(state(S,M,L), state(S,0,NL)) :-
    L < 8,
    L + M =< 8,
    NL is L + M.

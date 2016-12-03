%DFS
go(Start, Goal) :-
    empty_stack(Empty_been_list),
    stack(Start, Empty_been_list, Been_list),
    path(Start, Goal, Been_list).

path(Goal, Goal, Been_list) :-
    write('solution path is:'), nl,
    write('state(F,X,G,B)'), nl,
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
test:- go(state(left,left,left,left), state(right,right,right,right)).

%move is an edge of the state space.  Construct a state space

valid(state(X,Y,Y,Z)) :-
    X \== Y.
valid(state(X,Y,Z,Z)) :-
    X \== Z.

move(state(F,X,G,B), state(NF,X,G,B)) :-
    F == left,
    NF = right,
    not(valid(state(F,X,G,B))).
move(state(F,X,G,B), state(NF,X,G,B)) :-
    F == right,
    NF = left,
    not(valid(state(F,X,G,B))).

move(state(F,X,G,B), state(NF,NX,G,B)) :-
    F == left,
    X == left,
    NF = right,
    NX = right,
    not(valid(state(F,X,G,B))).
move(state(F,X,G,B), state(NF,NX,G,B)) :-
    F == right,
    X == right,
    NF = left,
    NX = right,
    not(valid(state(F,X,G,B))).

move(state(F,X,G,B), state(NF,X,NG,B)) :-
    F == left,
    G == left,
    NF = right,
    NG = right,
    not(valid(state(F,X,G,B))).
move(state(F,X,G,B), state(NF,X,NG,B)) :-
    F == right,
    G == right,
    NF = left,
    NG = left,
    not(valid(state(F,X,G,B))).

move(state(F,X,G,B), state(NF,X,G,NB)) :-
    F == left,
    B == left,
    NF = right,
    NB = right,
    not(valid(state(F,X,G,B))).
move(state(F,X,G,B), state(NF,X,G,NB)) :-
    F == right,
    B == right,
    NF = left,
    NB = left,
    not(valid(state(F,X,G,B))).

%% Write list

writelist([]).
writelist([H|T]):- write(H),nl,writelist(T).

%%%  Queue

empty_queue([]).

add_to_queue(E, [], [E]).
add_to_queue(E, [X|T], [X|NT]):-
     add_to_queue(E, T, NT).

remove_from_queue(X, [X|T], T).

member_queue(Element,Stack):-
      member(Element,Stack).

%% Set operators.

empty_set([]).

member_set(Element,Stack):-
      member(Element,Stack).

add_to_set(X, L, L):- member(X,L), !.
add_to_set(X, L, [X|L]).


% not operator
not(P):- P, !, fail; true.

%%%%%%% Breadth first search algorithm%%%%%%%%

state_record(State, Parent, [State, Parent]).

go(Start, Goal) :-
        empty_queue(Empty_open),
        state_record(Start, nil, State),
        add_to_queue(State, Empty_open, Open),
        empty_set(Closed),
        path(Open, Closed, Goal).

path(Open,_,_) :- empty_queue(Open),
                  write('graph searched, no solution found').

path(Open, Closed, Goal) :-
        remove_from_queue(Next_record, Open, _),
        state_record(State, _, Next_record),
        State = Goal,
        write('Solution path is: '), nl,
	write('state(S,M,L)'), nl,
        printsolution(Next_record, Closed).

path(Open, Closed, Goal) :-
        remove_from_queue(Next_record, Open, Rest_of_open),
        (bagof(Child, moves(Next_record, Open, Closed, Child), Children);Children = []),
        add_list_to_queue(Children, Rest_of_open, New_open),
        add_to_set(Next_record, Closed, New_closed),
%       nl, write(state), nl, write(Next_record), nl,
%       write(closed_list), nl, writelist(Closed),
%       write(queue), nl, writelist(Open),
        path(New_open, New_closed, Goal),!.

moves(State_record, Open, Closed, Child_record) :-
        state_record(State, _, State_record),
        move(State, Next),
        % not (unsafe(Next)),
        state_record(Next, _, Test),
        not(member_queue(Test, Open)),
        not(member_set(Test, Closed)),
        state_record(Next, State, Child_record).

printsolution(State_record, _):-
        state_record(State,nil, State_record),
        write(State), nl.

printsolution(State_record, Closed) :-
        state_record(State, Parent, State_record),
        state_record(Parent, Grand_parent, Parent_record),
        member(Parent_record, Closed),
        printsolution(Parent_record, Closed),
        write(State), nl.

add_list_to_queue([], Queue, Queue).
add_list_to_queue([H|T], Queue, New_queue) :-
        add_to_queue(H, Queue, Temp_queue),
        add_list_to_queue(T, Temp_queue, New_queue).



%% Test.
test:- go(state(0,0,8),state(0,4,4)).

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

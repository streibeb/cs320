largest([X], X).
largest([X|T], X) :- largest(T, M1), X > M1.
largest([X|T], M1) :- largest(T, M1), M1 > X.

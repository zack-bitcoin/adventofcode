#!/usr/bin/env swipl

:- initialization(main, main).

read_file(Stream,[]) :-
    at_end_of_stream(Stream).
read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream,X), 
    read_file(Stream,L).
main([File]) :-
    open(File, read, Str),
    read_file(Str, Lines),
    process(Lines, Sum),
    print(Sum),
    nl.

process([], 0).
process([H|T], Sum) :-
    re_split("mul\\([0-9][0-9]?[0-9]?,[0-9][0-9]?[0-9]?\\)", H, Split1),
    [_|Split2] = Split1,
    add_up(Split2, S2),
    process(T, S3),
    Sum is S2 + S3.
add_up([], 0).
add_up([H, _|T], Sum) :-
    re_split("[0-9]+", H, [_, X1, _, Y1, _]),
    number_string(X, X1),
    number_string(Y, Y1),
    add_up(T, S2),
    Sum is S2 + (X*Y).
    

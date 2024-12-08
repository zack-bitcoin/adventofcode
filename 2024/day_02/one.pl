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
    process(T, S),
    safe_check(H, X),
    Sum is X + S.

remove_spaces([" "|T], Q) :-
    remove_spaces(T, Q).
remove_spaces([A|T], [A|Q]) :-
    remove_spaces(T, Q).
remove_spaces([], []).

number_string_list([A|AT], [B|BT]) :-
    number_string(A, B),
    number_string_list(AT, BT).
number_string_list([], []).

safe_check(H, X) :-
    %X is 1 if it is safe, 0 otherwise.
    re_split("\\s", H, Split1),
    remove_spaces(Split1, Split2),
    number_string_list(Split, Split2),
    last(Split, Last),
    [First|_] = Split,
    Diff is Last - First,
    safe_check2(Split, Diff, X).

safe_check2([_], _, 1).
safe_check2([A, B|T], Diff, X) :-
    Diff > 0,
    B > A,
    B < A + 4,
    !,
    safe_check2([B|T], Diff, X).
safe_check2([A, B|T], Diff, X) :-
    Diff < 0,
    B < A,
    B > A - 4,
    !,
    safe_check2([B|T], Diff, X).
safe_check2(_A, _B, 0).

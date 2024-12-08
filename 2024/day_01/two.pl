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
    two_lists(Lines, L1, L2),
    count_doubles(L1, L2, Sum),
    print(Sum),
    nl.
count_doubles([], _, 0).
count_doubles([H|T], L2, Sum) :-
    count_doubles(T, L2, S1),
    count_doubles2(H, L2, S2),
    Sum is (S2 * H) + S1.
count_doubles2(_, [], 0).
count_doubles2(H, [H|T], Acc) :-
    count_doubles2(H, T, A2),
    Acc is A2 + 1.
count_doubles2(H, [_|T], Acc) :-
    count_doubles2(H, T, Acc).
two_lists([], [], []).
two_lists([H1|T1], [H2|T2], [H3|T3]) :-
    re_split("\\s+", H1, Split),
    [H2s, _, H3s] = Split,
    number_string(H2, H2s),
    number_string(H3, H3s),
    two_lists(T1, T2, T3).

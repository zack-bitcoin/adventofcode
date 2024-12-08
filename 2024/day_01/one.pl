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
    sort(0, @=<, L1, L3),
    sort(0, @=<, L2, L4),
    sum_diffs(L3, L4, Sum),
    print(Sum),
    nl.
two_lists([], [], []).
two_lists([H1|T1], [H2|T2], [H3|T3]) :-
    re_split("\\s+", H1, Split),
    [H2s, _, H3s] = Split,
    number_string(H2, H2s),
    number_string(H3, H3s),
    two_lists(T1, T2, T3).
sum_diffs([], [], 0).
sum_diffs([A|AT], [B|BT], Acc) :-
    sum_diffs(AT, BT, Acc2),
    Acc is Acc2 + abs(A - B).

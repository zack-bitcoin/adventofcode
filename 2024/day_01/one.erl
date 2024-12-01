-module(one).

-export([main/0]).


load([], A, B) -> {A, B};
load([S|T], A, B) -> 
    if
        (S == <<"">>) ->
            load(T, A, B);
        true ->
            [P1, P2] = string:split(binary_to_list(S), "   "),
            load(T, [P1|A], [P2|B])
    end.

main()->
    {ok, X} = file:read_file("input"),
    L = string:split(X, "\n", all),

    {A, B} = load(L, [], []),

    AS = lists:sort(A),
    BS = lists:sort(B),

    count(AS, BS).

s2i(X) ->
    {A, []} = string:to_integer(X),
    A.


count([A|AT], BS) ->
    X = occurances(A, BS),
    (s2i(A)*X) + count(AT, BS);
count([], _) -> 0.

occurances(A, []) ->
    0;
occurances(A, [A|T]) ->
    1 + occurances(A, T);
occurances(A, [_|T]) ->
    occurances(A, T).


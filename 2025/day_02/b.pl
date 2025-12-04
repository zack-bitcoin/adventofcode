%Not yet working



%entry split on ","
%data splti on "-"

main :-
    open('example', read, Stream),
    mainloop(Stream, 0, Result),
    close(Stream),
    nl,
    print(Result).

mainloop(Stream, Acc, Result) :-
    print('mainloop\n'),
    get_number(Stream, Number1, _),
    %get_char(Stream, '-'),
    get_number(Stream, Number2, Another),
    %get_char(Stream, Another),
    scan(Number1, Number2, 0, S),
    print(hd(", a")),
    print(" here"),
    %Comma = ',',
    Comma = ' ',
    Acc2 is Acc + S,
    ( Another == end_of_file ->
      Result = Acc2
    ; Another == Comma ->
      get_char(Stream, '\n'),
      mainloop(Stream, Acc2, Result)
    ; print("impossible error\n")
    ).

scan(N1, N2, _Acc, _Result) :-
    print([N1, N2, 'scan']).

get_number(Stream, Number, Next) :-
    print('get number \n'),
    read_line_to_codes(Stream, Codes, _Next),
    print(Codes),
    nl,
    number_chars(Number, Codes).
read_line_to_codes(Stream, Codes, Next) :-
    get_char(Stream, Char),
    print(hd("- abc")),
    print(" here\n"),
    %Dash = '-',
    %Dash = ' ',
    %Comma = ',',
    %Comma = ' ',
    ( Char == end_of_file ->
      Next = end_of_file,
      Codes = []
    ; atom_codes(Char, [45]) ->
      Next = Char,
      Codes = []
    ; atom_codes(Char, [44]) ->
      Next = Char,
      Codes = []
    ; Codes = [Char|Rest],
      read_line_to_codes(Stream, Rest)
    ).

main :-
    open('input', read, Stream),
    mainloop(Stream, 50, Result),
    close(Stream),
    nl,
    print(Result).
mainloop(Stream, Position, Acc2) :-
    get_char(Stream, Direction),
    ( Direction == end_of_file ->
      Acc2 = 0
    ; direction_convert(Direction, D),
      get_number(Stream, Number),
      clicks(Number, D, Position, Position2, 0, Acc),
      mainloop(Stream, Position2, Acc3),
      Acc2 is Acc + Acc3
    ).
direction_convert('L', -1).
direction_convert('R', 1).
get_number(Stream, Number) :-
    read_line_to_codes(Stream, Codes),
    number_chars(Number, Codes).
read_line_to_codes(Stream, Codes) :-
    get_char(Stream, Char),
    ( Char == end_of_file ->
      Codes = []
    ; Char == '\n' ->
      Codes = []
    ; Codes = [Char|Rest],
      read_line_to_codes(Stream, Rest)
    ).
clicks(0, _, P, P, A, A).
clicks(Number, Direction, Position, Position2, Acc1, AccF) :-
    ( Number > 99 ->
      Number100 is Number - 100,
      Acc2 is Acc1 + 1,
      clicks(Number100, Direction, Position, Position2, Acc2, AccF)
    ;
      Number1 is Number - 1,
      Position3 is (100 + Position + Direction) mod 100,
      ( Position3 == 0 ->
        Adiff = 1
      ; Adiff = 0
      ),
      Acc2 is Acc1 + Adiff,
      clicks(Number1, Direction, Position3, Position2, Acc2, AccF)
    ).



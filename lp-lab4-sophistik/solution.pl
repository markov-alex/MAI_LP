%3. Реализовать синтаксический анализатор арифметического выражения и
%вычислить его числовое значение. В выражении допустимы операции +,-,*,/,
%степень ^. Учитывать приоритеты операций.
%............................................................................................................
%Запрос:
%?- calculate([5, ‘+’, 3, ‘^’,2], X).
%Результат:
%X=14

calculate(L, V):-
    plus_min(L, V),!.

plus_min(E, V):-
    append(T, ['+'| E1], E),
    plus_min(T, V1),
    mult_div(E1, V2),
    V is V1 + V2.

plus_min(E, V):-
    append(T, ['-'| E1], E),
    plus_min(T, V1),
    mult_div(E1, V2),
    V is V1 - V2.

plus_min(E, V):-
    mult_div(E, V).

mult_div(T, V):-
    append(N, ['*' | T1], T),
    mult_div(N, V1),
    my_pow(T1, V2),
    V is V1 * V2.

mult_div(T, V):-
    append(N, ['/' | T1], T),
    mult_div(N, V1),
    my_pow(T1, V2),
    V is V1 / V2.

mult_div(T, V):-
    my_pow(T, V).

my_pow(T, V):-
    append(N, ['^', T2], T),
    my_pow(N, T1),
    V is T1 ** T2.

my_pow([V], V):-
    number(V).

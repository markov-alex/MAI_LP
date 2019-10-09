% Task 2: Relational Data

% The line below imports the data
:- ['three.pl'].

% 1)Получить таблицу групп и средний балл по каждой из групп

% Сумма оценок
% (список оценок, сумма оценок)
sum_grades([],0).
sum_grades([grade(X,Y)|T],N):- sum_grades(T,M), N is Y + M.

% Средний балл студента
% (имя студента, средняя оценка)
average_mark(S,Mark):-
    student(G, S, Y),
    sum_grades(Y, Sum),
    length(Y, Len),
    Mark is Sum / Len.

delete_all(_,[],[]).
delete_all(X,[X|L],L1):-delete_all(X,L,L1).
delete_all(X,[Y|L],[Y|L1]):- X \= Y, delete_all(X,L,L1).

remove_same([],[]).
remove_same([H|T],[H|T1]):-delete_all(H,T,T2), remove_same(T2,T1).

group_list(L):-
    findall(G, student(G,_,_), Gr),
    remove_same(Gr, L).

get_stud(G, L):-
    findall(S, student(G, S, _), L).
/*
stud_group([], G, L).
stud_group([H|T], H,  L):-
    get_stud(H, L).

get_stud_group(G, L):-
    group_list(Gr),
    stud_group(Gr, G, L).

*/
% 2)Для каждого предмета получить список студентов, не сдавших экзамен (grade=2)

all_studs(L):-
    findall(S, student(_, S, _), L).

s_not_passed(Sub, [grade(Sub,Y)|T]):- Y = 2, !.
s_not_passed(Sub, [_|T]):- s_not_passed(Sub, T).

stud_not_passed(S, Sub):-
    student(_, S, Y),
    s_not_passed(Sub, Y), !.

do_not_pass_sub([], Sub, []).
do_not_pass_sub([H|T], Sub, L):-
    student(_, H, Y),
    s_not_passed(Sub, Y), !, do_not_pass_sub(T, Sub, NL), append(H, NL, L).
do_not_pass_sub([H|T], Sub, L):-
    do_not_pass_sub(T, Sub, L).

list_of_not_passed(Sub, L):-
    all_studs(S),
    do_not_pass_sub(S, Sub, L).



% 3)Найти количество не сдавших студентов в каждой из групп
not_passed([grade(_, Y)|T]):- Y = 2, !.
not_passed([_|T]):- not_passed(T).

count_do_not_passed([], 0).
count_do_not_passed([H|T], C):-
    student(_, H, Y),
    not_passed(Y), !, count_do_not_passed(T, M), C is M + 1.
count_do_not_passed([H|T], C):-
    count_do_not_passed(T, C).

%сколько студентов из группы не сдали (группа, кол-во)
group_count(G, C):-
    get_stud(G, Gr),
    count_do_not_passed(Gr, C).

/*Вариант 14
В педагогическом институте Аркадьева, Бабанова, Корсакова, Дашков, Ильин и Флеров преподают географию, английский язык,
французский язык, немецкий язык, историю и математику. Преподаватель немецкого языка и преподаватель математики в студенческие
годы занимались художественной гимнастикой. Ильин старше Флерова, но стаж работы у него меньше, чем у преподавателя географии.
Будучи студентками, Аркадьева и Бабанова учились вместе в одном университете. Все остальные окончили педагогический институт.
Флеров отец преподавателя французского языка. Преподаватель английского языка самый старший из всех и по возрасту и по стажу.
Он работает в этом институте с тех пор, как окончил его. Преподаватели математики и истории его бывшие студенты.
Аркадьева старше преподавателя немецкого языка. Кто какой предмет преподает?
*/

subject(geography).
subject(english).
subject(french).
subject(german).
subject(history).
subject(math).

teach(Sub):- subject(Sub).
gymnastics(T).

is_older(T1, T2).
work_longer(T1, T2).

stud_together(T1 , T2).

from_ped(T):-
    not(stud_together(T, _)).
from_ped(T):-
    not(stud_together(_, T)).

is_father(T1, T2).

is_oldest(T):-
    is_older(T, _),
    work_longer(T, _).

is_teacher(T1, T2).

main([Arkadieva, Babanova, Korsakova, Dashkov, Ilin, Flerov]):-
    subject(Sub1),
    Arkadieva = teach(Sub1),
    subject(Sub2), Sub2 @< Sub1,
    Babanova = teach(Sub2),
    subject(Sub3), Sub3 @< Sub1, Sub3 @< Sub2,
    Korsakova = teach(Sub3),
    subject(Sub4), Sub4 @< Sub3, Sub4 @< Sub2, Sub2 @< Sub1,
    Dashkov = teach(Sub4),
    subject(Sub5), Sub5 @< Sub4, Sub5 @< Sub3, Sub5 @< Sub2, Sub5 @< Sub1,
    Ilin = teach(Sub5),
    subject(Sub6), Sub6 @< Sub5, Sub6 @< Sub4, Sub6 @< Sub3, Sub6 @< Sub2, Sub6 @< Sub1,
    Flerov = teach(Sub6),
    gymnastics(teach(math)),
    gymnastics(teach(german)),
    is_older(Ilin, Flerov),
    work_longer(teach(geography), Ilin),
    stud_together(Arkadieva, Babanova),
    is_father(Flerov, teach(french)),
    is_oldest(teach(english)),
    is_teacher(teach(english), teach(math)),
    is_teacher(teach(english), teach(history)),
    is_older(Arkadieva, teach(german)).

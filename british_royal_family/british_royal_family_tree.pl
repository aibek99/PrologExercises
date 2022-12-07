% Facts %

male('King George VI').
male('Prince Philip').
male('Charles').
male('Prince Andrew').
male('Prince Edward').
male('Prince William').
male('Prince Harry').
male('Prince George of Cambridge').
male('Prince Louis of Cambridge').
male('Archie Harrison Mountbatten-Windsor').

female('Queen Elizabeth').
female('Queen Elizabeth II').
female('Princess Margaret').
female('Camila').
female('Diana').
female('Anne').
female('Catherine').
female('Meghan').
female('Princess Charlotte of Cambridge').

parent('King George VI', 'Queen Elizabeth II').
parent('Queen Elizabeth', 'Queen Elizabeth II').
parent('King George VI', 'Princess Margaret').
parent('Queen Elizabeth', 'Princess Margaret').

parent('Prince Philip', 'Charles').
parent('Queen Elizabeth II', 'Charles').
parent('Prince Philip', 'Anne').
parent('Queen Elizabeth II', 'Anne').
parent('Prince Philip', 'Prince Andrew').
parent('Queen Elizabeth II', 'Prince Andrew').
parent('Prince Philip', 'Prince Edward').
parent('Queen Elizabeth II', 'Prince Edward').

parent('Prince Philip', 'Prince William').
parent('Queen Elizabeth II', 'Prince William').
parent('Prince Philip', 'Prince Harry').
parent('Queen Elizabeth II', 'Prince Harry').

parent('Prince William', 'Prince George of Cambridge').
parent('Catherine', 'Prince George of Cambridge').
parent('Prince William', 'Princess Charlotte of Cambridge').
parent('Catherine', 'Princess Charlotte of Cambridge').
parent('Prince William', 'Prince Louis of Cambridge').
parent('Catherine', 'Prince Louis of Cambridge').


wife('Queen Elizabeth', 'King George VI').
wife('Prince Philip', 'Queen Elizabeth II').
wife('Catherine', 'Prince William').
wife('Meghan', 'Prince Harry').
wife('Camila', 'Charles').
ex_wife('Diana', 'Charles').

husband('King George VI', 'Queen Elizabeth').
husband('Queen Elizabeth II', 'Prince Philip').
husband('Prince William', 'Catherine').
husband('Prince Harry', 'Meghan').
husband('Charles', 'Camila').
ex_husband('Charles', 'Diana').

% Rules %

mother(X, Y) :- parent(X, Y), female(X).
father(X, Y) :- parent(X, Y), male(X).

sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.
brother(X, Y) :- sibling(X, Y), male(X).
sister(X, Y) :- sibling(X, Y), female(X).

grandparent(X, Y) :- parent(Z, Y), parent(X, Z).
grandmother(X, Y) :- grandparent(X, Y), female(X).
grandfather(X, Y) :- grandparent(X, Y), male(X).

aunt(X, Y) :- sister(X, Z), parent(Z, Y).
aunt(X, Y) :- wife(X, T), brother(T, Z), parent(Z, Y).
aunt(X, Y) :- ex_wife(X, T), brother(T, Z), parent(Z, Y).
uncle(X, Y) :- brother(X, Z), parent(Z, Y).
uncle(X, Y) :- husband(X, T), sister(T, Z), parent(Z, Y).
uncle(X, Y) :- ex_husband(X, T), sister(T, Z), parent(Z, Y).


children(X, Y) :- parent(Y, X).
son(X, Y) :- children(X, Y), male(X).
daughter(X, Y) :- children(X, Y), female(Y).

grandchild(X, Y) :- grandparent(Y, X).
grandson(X, Y) :- grandchild(X, Y), male(X).
granddaughter(X, Y) :- grandchild(X, Y), female(X).

neice(X, Y) :- sibling(Y, Z), daughter(X, Z).
nephew(X, Y) :- sibling(Y, Z), son(X, Z).
cousin(X, Y) :- children(X, Z), aunt(Z, Y).
cousin(X, Y) :- children(X, Z), uncle(Z, Y).

sister_in_law(X, Y) :- sister(X, Z), husband(Z, Y).
sister_in_law(X, Y) :- sister(X, Z), wife(Z, Y).
sister_in_law(X, Y) :- wife(X, Z), brother(Z, Y).

brother_in_law(X, Y) :- brother(X, Z), husband(Z, Y).
brother_in_law(X, Y) :- brother(X, Z), wife(Z, Y).
brother_in_law(X, Y) :- husband(X, Z), sister(Z, Y).

mother_in_law(X, Y) :- mother(X, Z), husband(Z, Y).
mother_in_law(X, Y) :- mother(X, Z), wife(Z, Y).

father_in_law(X, Y) :- father(X, Z), husband(Z, Y).
father_in_law(X, Y) :- father(X, Z), wife(Z, Y).

ex_sister_in_law(X, Y) :- sister(X, Z), ex_husband(Z, Y).
ex_sister_in_law(X, Y) :- sister(X, Z), ex_wife(Z, Y).
ex_sister_in_law(X, Y) :- ex_wife(X, Z), brother(Z, Y).

ex_brother_in_law(X, Y) :- brother(X, Z), ex_husband(Z, Y).
ex_brother_in_law(X, Y) :- brother(X, Z), ex_wife(Z, Y).
ex_brother_in_law(X, Y) :- ex_husband(X, Z), sister(Z, Y).

ex_mother_in_law(X, Y) :- mother(X, Z), ex_husband(Z, Y).
ex_mother_in_law(X, Y) :- mother(X, Z), ex_wife(Z, Y).

ex_father_in_law(X, Y) :- father(X, Z), ex_husband(Z, Y).
ex_father_in_law(X, Y) :- father(X, Z), ex_wife(Z, Y).

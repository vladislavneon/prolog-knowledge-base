main :-
	include_bases,
	helloing, !,
	menu.

include_methods :-
	consult('io_methods.pl'),
	consult('answering.pl'),
	consult('displaying.pl'),
	consult('editing_database.pl'),
	consult('search_methods.pl'),
	consult('synonym_methods.pl').

include_bases :-
	consult('properties_base.pl'),
	consult('description_base.pl'),
	consult('synonym_base.pl').

helloing :-
	writef("Здравствуйте!"), nl, nl.

menu :-
	show_options,
	repeat,
	read_option(Option),
	run_option(Option),
	Option == "exit".

read_option(Option) :-
	writef("\nВыберите действие.\n"),
	read_str(Option).

run_option(Option) :-
	Option == "1", ask_question, !.
run_option(Option) :-
	Option == "2", edit_database, !.
run_option(Option) :-
	Option == "3", add_synonyms, !.
run_option(Option) :-
	Option == "4", show_properties, !.
run_option(Option) :-
	Option == "5", show_description, !.
run_option(Option) :-
	Option == "h", show_options, !.
run_option(Option) :-
	Option == "exit", finish_program, !.
run_option(Option) :-
	Option == "2.1", add_new_object, !.
run_option(Option) :-
	Option == "2.2", add_properties, !.
run_option(Option) :-
	Option == "2.3", remove_properties, !.
run_option(Option) :-
	Option == "2.4", edit_description, !.
run_option(Option) :-
	Option == "2.0", !.
run_option(_) :-
	ask_for_finish, !.


show_options :-
	writef("Введите: \n"),
	writef("1 - Задать вопрос\n"),
	writef("2 - Изменить базу объектов\n"),
	writef("3 - Добавить синонимы\n"),
	writef("4 - Посмотреть свойства объекта\n"),
	writef("5 - Посмотреть описание объекта\n"),
	writef("h - Открыть список опций\n"),
	writef("exit - Завершить программу\n"), !.

edit_database :-
	writef("Выберите действие:\n"),
	writef("1 - Добавить новый объект\n"),
	writef("2 - Добавить свойства объекта\n"),
	writef("3 - Удалить свойства объекта\n"),
	writef("4 - Изменить описание объекта\n"),
	writef("0 - Возврат\n"),
	read_option(Option),
	string_concat("2.", Option, RealOption),
	run_option(RealOption), !.

save_base(BaseName, Pred) :-
	tell(BaseName),
	listing(Pred),
	told.

save_base(BaseName, Pred1, Pred2) :-
	tell(BaseName),
	listing(Pred1),
	listing(Pred2),
	told.

save_all :-
	save_base('properties_base.pl', reference),
	save_base('description_base.pl', description).

ask_for_finish :-
	writef("Вы действительно хотите выйти? (y/n) "),
	get_single_char(C),
	nl,
	ask_for_finish_handle(C), !.

ask_for_finish_handle(C) :-
        C == 121,
	finish_program, !.

ask_for_finish_handle(C) :-
	C > 0,
	C < 256, !.

ask_for_finish_handle(_) :-
	finish_program, !.


finish_program :-
	save_all,
	writef("До свидания!\n"), nl,
	writef("Нажимте любую клавишу для выхода"), nl, nl,
	writef("База знаний ЧГК, 2016"), nl, nl,
	get_single_char(_),
	halt.

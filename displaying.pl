%predicates for showing properties of user object

show_properties :-
	repeat,
	show_properties_read(Object),
	show_properties_handle(Object), !.

show_properties_read(Object) :-
	writef("Введите объект (пустую строку для отмены): \n"),
	read_str(Object).

show_properties_handle(Object) :-
	Object == "",
	true.

show_properties_handle(Object) :-
	Object \== "",
	reference(Object, PropertiesList),
	writef("У объекта \""), writef(Object), writef("\" "), writef("есть свойства:\n\n"),
	write_list_of_strings_tab(PropertiesList), nl, !.

show_properties_handle(Object) :-
	Object \== "",
	writef("Объекта \""), writef(Object), writef("\" "), writef("нет в базе.\n"), fail.

%showing fixed object

show_properties(Object) :-
	show_properties_handle(Object).

%predicates for showing description of user object

show_description :-
	repeat,
	show_description_read(Object),
	show_description_handle(Object), !.

show_description_read(Object) :-
	writef("Введите объект (пустую строку для отмены): \n"),
	read_str(Object).

show_description_handle(Object) :-
	Object == "",
	true.

show_description_handle(Object) :-
	Object \== "",
	description(Object, Description),
	writef("\t\t"), writef(Object), writef(":\n\n"),
	write_description_list(Description), !.

show_description_handle(Object) :-
	Object \== "",
	writef("Объекта \""), writef(Object), writef("\" "), writef("нет в базе.\n"), fail.

%this shows fixed description of the fixed object

show_description(Object) :-
	show_description_handle(Object).

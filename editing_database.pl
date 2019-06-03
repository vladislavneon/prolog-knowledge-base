%adding new object predicates

add_new_object :-
	repeat,
	add_new_object_read(Object),
	add_new_object_handle(Object), !.

add_new_object_read(Object) :-
	writef("Введите объект, который вы хотите добавить (пустую строку для отмены): \n"),
	read_str(Object).

add_new_object_handle(Object) :-
	Object == "",
	true, !.

add_new_object_handle(Object) :-
	Object \== "",
	in_base(Object),
	writef("Объект \""), writef(Object), writef("\" уже есть в базе.\n"), !,
	fail.

add_new_object_handle(Object) :-
	Object \== "",
	add_new_object_reference(Object),
	add_new_object_description(Object),
	writef("Объект \""), writef(Object), writef("\" успешно добавлен в базу.").

add_new_object_reference(Object) :-
	writef("Введите свойства объекта (каждое с новой строки, Enter для завершения ввода):\n"),
	read_list_of_strings(New_properties_list),
	assertz(reference(Object, New_properties_list)).

add_new_object_description(Object) :-
	writef("Введите описание объекта (каждый абзац с новой строки, Enter для завершения ввода):\n"),
	read_list_of_strings(DescriptionList),
	assertz(description(Object, DescriptionList)).

%adding new properties to object predicates

add_properties :-
	repeat,
	add_properties_read_object(Object),
	add_properties_handle_object(Object), !.

add_properties_read_object(Object) :-
	writef("Введите объект, которому вы хотите добавить новые свойства (пустую строку для отмены): \n"),
	read_str(Object).

add_properties_handle_object(Object) :-
	Object == "",
	true, !.

add_properties_handle_object(Object) :-
	Object \== "",
	show_properties(Object),
	add_properties_read(NewProperties),
	add_properties_handle(Object, NewProperties), !.

add_properties_read(NewProperties) :-
	writef("Введите свойства объекта, которые вы хотите добавить (каждое с новой строки, Enter для завершения ввода):\n"),
	read_list_of_strings(NewProperties).

add_properties_handle(_, NewProperties) :-
	length(NewProperties, 0),
        !.

add_properties_handle(Object, NewProperties) :-
	length(NewProperties, 1),
	selectchk(Property, NewProperties, _),
	reference(Object, CurProperties),
	member(Property, CurProperties),
	!.

add_properties_handle(Object, NewProperties) :-
	length(NewProperties, 1),
	selectchk(Property, NewProperties, _),
	reference(Object, CurProperties),
	add_properties_add(Object, CurProperties, Property),
	writef("Свойства успещно добавлены в базу."),
	!.

add_properties_handle(Object, NewProperties) :-
	length(NewProperties, L),
	L > 1,
	selectchk(Property, NewProperties, NewPropertiesTail),
	reference(Object, CurProperties),
	member(Property, CurProperties),
	!,
	add_properties_handle(Object, NewPropertiesTail).

add_properties_handle(Object, NewProperties) :-
	length(NewProperties, L),
	L > 1,
	selectchk(Property, NewProperties, NewPropertiesTail),
	reference(Object, CurProperties),
	add_properties_add(Object, CurProperties, Property),
	!,
	add_properties_handle(Object, NewPropertiesTail).

add_properties_add(Object, CurProperties, Property) :-
	NewProperties = [Property | CurProperties],
	retract(reference(Object, _)), !,
	assert(reference(Object, NewProperties)).

%removing some properties

remove_properties :-
	repeat,
	remove_properties_read_object(Object),
	remove_properties_handle_object(Object), !.

remove_properties_read_object(Object) :-
	writef("Введите объект, у которого вы хотите удалить свойства (пустую строку для отмены): \n"),
	read_str(Object).

remove_properties_handle_object(Object) :-
	Object == "",
	!.

remove_properties_handle_object(Object) :-
	show_properties(Object),
	remove_properties_read(Prop_to_delete),
	remove_properties_handle(Object, Prop_to_delete).

remove_properties_read(Prop_to_delete) :-
	writef("Введите свойства объекта, которые вы хотите удалить (каждое с новой строки, Enter для завершения ввода):\n"),
	read_list_of_strings(Prop_to_delete).

remove_properties_handle(_, Prop_to_delete) :-
	length(Prop_to_delete, 0),
	!.

remove_properties_handle(Object, Prop_to_delete) :-
	length(Prop_to_delete, 1),
	selectchk(Property, Prop_to_delete, _),
	reference(Object, CurProperties),
	member(Property, CurProperties),
	remove_properties_remove(Object, CurProperties, Property),
	writef("Свойства удалены."),
	!.

remove_properties_handle(_, Prop_to_delete) :-
	length(Prop_to_delete, 1),
        !.

remove_properties_handle(Object, Prop_to_delete) :-
	selectchk(Property, Prop_to_delete, Prop_to_deleteTail),
	reference(Object, CurProperties),
	member(Property, CurProperties),
	remove_properties_remove(Object, CurProperties, Property), !,
	remove_properties_handle(Object, Prop_to_deleteTail).

remove_properties_handle(Object, Prop_to_delete) :-
	selectchk(_, Prop_to_delete, Prop_to_deleteTail),
	!,
	remove_properties_handle(Object, Prop_to_deleteTail).

remove_properties_remove(Object, CurProperties, Property) :-
	select(Property, CurProperties, NewProperties),
	retract(reference(Object, _)), !,
	assert(reference(Object, NewProperties)).

%editing descriptions

edit_description :-
	repeat,
	edit_description_read_object(Object),
	edit_description_handle_object(Object), !.

edit_description_read_object(Object) :-
	writef("Введите объект, описание которого вы хотите изменить (пустую строку для отмены): \n"),
	read_str(Object).

edit_description_handle_object(Object) :-
	Object == "",
	!.

edit_description_handle_object(Object) :-
	show_description(Object),
	edit_description_read(NewDescription),
	edit_description_handle(Object, NewDescription).

edit_description_read(Description) :-
	writef("Введите новое описание объекта (каждый абзац с новой строки, Enter для завершения ввода):\n"),
	read_list_of_strings(Description).

edit_description_handle(_, NewDescription) :-
	NewDescription == [],
	!.

edit_description_handle(Object, NewDescription) :-
	retract(description(Object, _)), !,
	assert(description(Object, NewDescription)),
	writef("Новое описание сохранено.").


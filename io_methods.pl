read_list_of_strings(List) :-
	read_line_to_string(user_input, String), !,
	insert_string_to_list(String, List).

insert_string_to_list(String, List) :-
	String == "",
	List = [], !.
insert_string_to_list(String, List) :-
	String \== "",
	List = [String | SubList], ! ,
	read_list_of_strings(SubList).

read_str(String) :-
	read_line_to_string(user_input, String), !.

write_list_of_strings(List) :-
	length(List, 0),
	!.
write_list_of_strings(List) :-
	length(List, 1),
	member(String, List),
	writef(String), nl, !.
write_list_of_strings(List) :-
	length(List, Length),
	Length > 1,
	selectchk(String, List, SubList),
	writef(String), nl,
	write_list_of_strings(SubList).


write_list_of_strings_tab(List) :-
	length(List, 0),
	!.
write_list_of_strings_tab(List) :-
	length(List, 1),
	member(String, List),
	writef("\t"),
	writef(String), nl, !.
write_list_of_strings_tab(List) :-
	length(List, Length),
	Length > 1,
	selectchk(String, List, SubList),
	writef("\t"),
	writef(String), nl,
	write_list_of_strings_tab(SubList).

write_description_list(List) :-
	length(List, 0),
	!.

write_description_list(List) :-
	length(List, 1), !,
	member(String, List),
	writef("\t"), writef(String), nl, !.

write_description_list(List) :-
	selectchk(String, List, SubList),
	writef("\t"), writef(String), nl,
	write_description_list(SubList).

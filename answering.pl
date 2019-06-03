/*find_answer(Answer, List_of_properties) :- length(List_of_properties, 1), member(Property, List_of_properties), refer_to(Answer, Property).
find_answer(Answer, List_of_properties) :- length(List_of_properties, Length), Length > 1, selectchk(Property, List_of_properties, SubList), refer_to(Answer, Property), find_answer(Answer, SubList).
*/

satisfy(Answer, Property) :-
	reference(Answer, Properties_of_answer),
	member(Property, Properties_of_answer).

find_answer(Answer, List_of_properties) :-
	length(List_of_properties, 1),
	member(Property, List_of_properties),
	satisfy(Answer, Property).

find_answer(Answer, List_of_properties) :-
	length(List_of_properties, Length),
	Length > 1,
	selectchk(Property, List_of_properties, SubList),
	satisfy(Answer, Property),
	find_answer(Answer, SubList).

ask_question :-
	writef("Введите свойства искомого объекта.\n"),
	writef("Вводите каждое свойство с новой строки. Когда все свойства будут набраны, введите пустую строку.\n"),
	read_list_of_strings(List_of_properties),
	findall(Answer, find_answer(Answer, List_of_properties), AnswerList),
	handle_answer_list(AnswerList),
	!.

handle_answer_list(AnswerList) :-
	length(AnswerList, Length),
	Length > 50,
	writef("Мы нашли более 50 ответов по вашему запросу. Попробуйте его уточнить\n"),
	writef("Повторить? (y/n) "),
	get_single_char(UserReply),
	handle_answer_list_too_many(UserReply).

handle_answer_list(AnswerList) :-
	length(AnswerList, Length),
	Length < 51,
	Length > 20,
	writef("Мы нашли более 20 ответов по вашему запросу.\n"),
	writef("Что будем делать? (r - повторить, s - показать все, b - отмена) "),
	get_single_char(UserReply),
	handle_answer_list_many(UserReply, AnswerList).

handle_answer_list(AnswerList) :-
	length(AnswerList, Length),
	Length < 21,
	Length > 0,
	show_all_answers(AnswerList).

handle_answer_list(AnswerList) :-
	length(AnswerList, 0),
	writef("К сожалению, в нашей базе нет ответов на ваш запрос. Вы можете добавить новые свойства в базу.\n").


handle_answer_list_too_many(UserReply) :-
	char_code('y', UserReply),
	ask_question.

handle_answer_list_too_many(UserReply) :-
	char_code('n', UserReply),
	true.

handle_answer_list_too_many(_) :-
	true.


handle_answer_list_many(UserReply, _) :-
	char_code('r', UserReply),
	ask_question.

handle_answer_list_many(UserReply, AnswerList) :-
	char_code('s', UserReply),
	show_all_answers(AnswerList).

handle_answer_list_many(UserReply, _) :-
	char_code('b', UserReply),
	true.


show_all_answers(AnswerList) :-
	writef("По вашему запросу мы нашли следующие возможные ответы:\n\n"),
	write_list_of_strings_tab(AnswerList), nl,
	writef("Надеемся, вы нашли правильный ответ ;)\n").

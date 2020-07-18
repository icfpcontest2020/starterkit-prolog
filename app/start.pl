#!/usr/bin/env swipl

:- use_module(library(http/http_client)).

:- initialization main.

main :-
    current_prolog_flag(argv, [SERVER_URL, PLAYER_KEY]),
    write('ServerUrl: '), write(SERVER_URL),
    write('; PlayerKey: '), writeln(PLAYER_KEY),
    catch(
	http_post(SERVER_URL, [body = PLAYER_KEY],
		  Response, [status_code(Status)]),

	CatcherTerm,

	( writeln('Unexpected server response:'),
	  format("~q", [CatcherTerm]),
	  halt(1)
	)
    ),
    ( (Status == 200, atom_length(Response, Res_len), Res_len > 0) ->

      write('Server response: '), writeln(Response) ;

      writeln('Unexpected server response:'),
      write('HTTP code: '), writeln(Status),
      write('Response body: '), writeln(Response),
      halt(2) ),
    halt(0).
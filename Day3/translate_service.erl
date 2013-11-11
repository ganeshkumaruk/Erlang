-module(translate_service).
-export([loop/0, translate/2,monitor/0,destroy/0]).

loop() ->
	receive
		{From, "casa"} ->
			From ! "house",
			loop();
		{From, "blanca"} ->
			From ! "white",
			loop();
		{From, _} ->
			From ! "I don't understand.",
			loop()
	end.

translate(To, Word) ->
	To ! {self(), Word},
	receive
		Translation -> Translation
	end.

destroy() ->
	io:format("bang.~n"),
	exit({self,die,at,erlang:time()}).

monitor() ->
  process_flag(trap_exit, true),
  receive
    new ->
      io:format("~nCreating new etc..~n"),
      register(translator, spawn_link(fun loop/0)),
      monitor();
    {'EXIT', From, Reason} ->
      io:format("Translator ~p dies with the reason ~p", [From, Reason]),
      io:format("Restarting..."),
      self() ! new,
      monitor()
end.

% Translator = spawn(fun translate_service:loop/0).
% translate_service:translate(Translator, "blanca").
% translate_service:translate(Translator, "casa").
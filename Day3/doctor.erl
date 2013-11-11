-module(doctor).
-export([loop/0]).
loop() ->
	process_flag(trap_exit, true),
	receive
		new ->
		io:format("Creating and monitoring process.~n"),
		register(revolver, spawn_link(fun roulette:loop/0)),
		loop();
		{'EXIT', From, Reason} ->
			io:format("The shooter ~p died with reason ~p.", [From, Reason]),
			io:format(" Restarting. ~n"),
			self() ! new,
			loop()
	end.

monitor() ->
  process_flag(trap_exit, true),
  receive
    new ->
      io:format("Creating and monitoring new Doctor process.~n"),
      register(doctor, spawn_link(fun loop/0)),
      doctor ! new,
      monitor();
    {'EXIT', From, Reason} ->
      io:format("The shooter doctor ~p died with reason ~p.~n", [From, Reason]),
      io:format("Restarting... ~n"),
      self() ! new,
      monitor()
end.

% Doc = spawn(fun doctor:loop/0).
% % we must create a new revolve before use it!
% Doc ! new.
% % there we go:
% revolver ! 2.
% revolver ! 3.
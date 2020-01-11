-module(hardware).

%% API
-export([return_change/1, drop_cup/0, prepare/1, receive_order/1, ask_for_money/1, welcome/1, goodbye/0]).


receive_order(Coffee) ->
  io:format("[Machine]  Got order for ~p.~n", [Coffee]).

return_change(Payment) ->
  io:format("[Machine]  Returned ~w in change~n", [Payment]),
  timer:sleep(1000).


drop_cup() ->
  io:format("[Machine]  Dropped cup~n", []),
  timer:sleep(1000).


prepare(Type) ->
  io:format("[Machine]  Preparing ~p~n", [Type]),
  timer:sleep(5000).

ask_for_money(Amount) ->
  io:format("[Machine]  Please insert ~w.~n", [Amount]),
  timer:sleep(1000).

welcome(AvailableCoffees) ->
  io:format("[Machine]  Welcome, pick your coffee~n"),
  WithIndex = lists:zip(lists:seq(1, length(AvailableCoffees)), AvailableCoffees),
  lists:foreach(
    fun({I, {C, P}}) ->
      io:format("~w. ~p - Price: ~p~n", [I, C, P])
    end, WithIndex),
  io:format("~n").


goodbye() -> io:format("[Machine]  Enjoy your coffee~n").
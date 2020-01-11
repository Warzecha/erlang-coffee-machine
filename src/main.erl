-module(main).

%% API
-export([run/0]).

run() ->
  MachinePID = spawn(coffee_m, machine, []),
  order(MachinePID).


order(MachinePID) ->
  io:format("[User]     Ordering coffee.~n"),
  MachinePID ! {self(), order, americano},
  wait_to_pay(MachinePID).


wait_to_pay(MachinePID) ->
  receive
    {pay, Price} ->
      pay(MachinePID, 110),
      wait_to_pay(MachinePID);
    {wait_for_order} ->
      wait_for_order(MachinePID)
  end.

pay(MachinePID, Amount) ->
  io:format("[User]     Inserted ~w.~n", [Amount]),
  MachinePID ! {self(), payment, Amount}.


wait_for_order(MachinePID) ->
  io:format("[User]     Waiting for order ~n"),
  receive
    {order_ready, Coffee} ->
      io:format("[User]     Collecting my ~p coffee ~n", [Coffee]),
      MachinePID ! {order_collected}
  end.



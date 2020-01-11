
-module(manual).

%% API
-export([run/0]).

run() ->
  MachinePID = spawn(coffee_m, machine, []),
  order(MachinePID).


order(MachinePID) ->
  {ok, Number} = io:read("Enter a coffee number: "),
  io:format("[User]     Ordering coffee.~n"),
  MachinePID ! {self(), order_by_number, Number},
  wait_to_pay(MachinePID).



wait_to_pay(MachinePID) ->
  receive
    {pay, Price} ->
      io:format("REQUEST ~w ~n", [Price]),
      insert_coin(MachinePID),
      wait_to_pay(MachinePID);
    {wait_for_order} ->
      wait_for_order()
  end.

insert_coin(MachinePID) ->
  {ok, Amount} = io:read("Enter coin value: "),
  pay(MachinePID, Amount).

pay(MachinePID, Amount) ->
  io:format("[User]     Inserted ~w.~n", [Amount]),
  MachinePID ! {self(), payment, Amount}.

wait_for_order() ->
  io:format("[User]     Waiting for order ~n"),
  receive
    {order_ready, Coffee} ->
      {ok, _} = io:read("Press enter any non empty string to collect your order. "),
      io:format("[User]     Collecting my ~p coffee ~n", [Coffee])
  end.

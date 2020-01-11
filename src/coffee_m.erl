-module(coffee_m).

%% API
-export([machine/0]).

-import(hardware, [reboot/0]).


machine() ->
  idle_machine().


idle_machine() ->
  AvailableCoffees = [{americano, 200}, {cappuccino, 300}],
  CoffeePrices = maps:from_list(AvailableCoffees),
  hardware:welcome(AvailableCoffees),
  receive
    {SenderPID, order, Coffee} ->
      hardware:receive_order(Coffee),
      Price = maps:get(Coffee, CoffeePrices),
      wait_for_payment(SenderPID, Price, Coffee);
    {SenderPID, order_by_number, CoffeeNumber} ->
      {Coffee, Price} = lists:nth(CoffeeNumber, AvailableCoffees),
      hardware:receive_order(Coffee),
      wait_for_payment(SenderPID, Price, Coffee)
  end.


wait_for_payment(SenderPID, TargetAmount, Coffee) ->
  hardware:ask_for_money(TargetAmount),
  SenderPID ! {pay, TargetAmount},
  receive
    {SenderPID, payment, Amount} ->
      if
        TargetAmount == Amount ->
%%          correct amount
          prepare_coffee(Coffee, SenderPID);

        TargetAmount > Amount ->
%%         Not enough
          AmountLeft = TargetAmount - Amount,
          wait_for_payment(SenderPID, AmountLeft, Coffee);

        true ->
%%          Payed more
          Change = Amount - TargetAmount,
          hardware:return_change(Change),
          prepare_coffee(Coffee, SenderPID)
      end
  end.

prepare_coffee(Coffee, SenderPID) ->
  hardware:drop_cup(),
  hardware:prepare(Coffee),
  SenderPID ! {wait_for_order},
  SenderPID ! {order_ready, Coffee},
  receive
    {order_collected} ->
      hardware:goodbye(),
      idle_machine()

  end.



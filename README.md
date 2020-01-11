# Erlang Coffee Machine
This is a university project for the Erlang class.

The task is to build an application to supervise and simulate an automated coffee maker vending machine. 
Vending machines are automated machines that usually provide a snack, beverages or small items to customers after they insert a sufficient amount of cash and later choose the product. Nowadays, it is also common to see modern, credit card enabled vending machines.
In this case, the application should fulfill the task of managing the operations of a vending machine that:
- Allows the user to choose a type of coffee from a list of available options via number input,
- The coffees differ by the price only,
- Accepts coins of all denominations,
- When the inserted amount of money is sufficient the coffee-making process will begin,
- If the user inserted an amount exceeding the price, the change is returned.

## Coffee making process
The vending machine is capable of brewing coffee directly before serving it to customers to achieve a distinct aroma. The process can be broken down into consecutive steps:
1. Paper cup dispenser places a single container just beneath the coffee outlet,
2. The simulated brewing process takes about 5s,
3. The user is notified that he can collect his order. After that, the machine goes back to its idle state.

## Implementation
The coffee machine is implemented as a *Final State Machine*

![fsm_diagram](https://raw.githubusercontent.com/Warzecha/erlang-coffee-machine/blob/master/img/fsm_diagram.png)

There are 2 modes:
- automatic
- manual

#### Automatic
This mode allows for testing of the application. You can program automated sequences of inputs and they are executed in sequence.

#### Manual
In this mode, you can order a cup of your favorite, fresh-brewed coffee yourself and experience the process.


-module(carros).
-export([main/1,start/0, loop/1, add_car/3, list_cars/0, print_cars/1]).


usage() -> io:format("Usage: Coloque um texto entre aspas \n"), halt(1).
main([String]) ->
    try
        io:format("Hello, ~s!~n", [String]),
        start()
    catch
        _:_ -> usage()
    end;
    main(_) -> usage(),
  Cars = [{"Toyota", "Camry", 2023}, {"Honda", "Civic", 2022}, {"Ford", "Mustang", 2023},{"Toyota","Camry",2023},{"Honda","Civic",2022},{"Ford","Mustang",2023}]
.


start() ->
  io:format("Car Registry~n"),
  loop([])
.
add_car(Name, Model, Year) ->
  Car = {Name, Model, Year},
  receive
    {From, add, Car} ->
      io:format("Added car: ~s ~s ~p~n", [Name, Model, Year]),
      From ! {self(), ok}
  end.


list_cars() ->
  self() ! {self(), list},
  receive
    {_, Cars} ->
      print_cars(Cars)
  end.

  loop(Cars) ->
    receive
      {From, add, Car} ->
        loop([Car | Cars]),
        From ! {self(), ok};
      {From, list} ->
        loop(Cars),
        From ! {self(), Cars}
    end.

print_cars([]) ->
io:format("No cars in the registry.~n");
print_cars([{Name, Model, Year} | Rest]) ->
io:format("~s ~s ~p~n", [Name, Model, Year]),
print_cars(Rest).



%% Cars = [{"Toyota", "Camry", 2023}, {"Honda", "Civic", 2022}, {"Ford", "Mustang", 2023}],[{"Toyota","Camry",2023},{"Honda","Civic",2022},{"Ford","Mustang",2023}].

%% Execucao utilizando a funcao main
%% escript carros.erl "World"

%% Execucao utilizando a funcao diretamente
%% erl -noshell -s carros start "World" -s init stop
 
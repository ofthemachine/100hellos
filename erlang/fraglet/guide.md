# Erlang Fraglet Guide

## Language Version
Erlang/OTP (latest available in Alpine)

## Execution Model
- Compiled, then executed via Erlang VM
- Execution via `erl -noshell -s module function -s init stop`

## Key Characteristics
- Functional programming language
- Immutable data structures
- Pattern matching
- Concurrency primitives (processes, message passing)
- Case-sensitive
- Atoms (constants like `hello`, `world`)
- Lists: `[1, 2, 3]`
- Tuples: `{a, b, c}`
- Variables start with uppercase: `X`, `Name`
- Atoms start with lowercase: `hello`, `world`

## Fragment Authoring
Write valid Erlang code. Your fragment can define functions, export them, and write complete module code. You can:

- Define multiple functions
- Export functions using `-export([function_name/arity])`
- Write complete function implementations
- Use pattern matching, guards, and recursion

**Important**: The execution script calls `main/0`, so your fragment must export and define `main/0` for the code to execute. You can define additional helper functions as needed.

## Available Libraries
Standard Erlang/OTP library is available. No additional packages are pre-installed.

## Common Patterns
- Print: `io:fwrite("message~n")` or `io:format("message~n")`
- String formatting: `io:format("Value: ~p~n", [Value])`
- Lists: `[1, 2, 3]`
- Tuples: `{ok, Value}` or `{error, Reason}`
- Pattern matching: `{X, Y} = {1, 2}`
- Guards: `function(X) when X > 0 -> ...`
- Recursion: `factorial(0) -> 1; factorial(N) -> N * factorial(N-1).`
- List comprehensions: `[X*2 || X <- [1,2,3]]`
- Higher-order functions: `lists:map(fun(X) -> X*2 end, [1,2,3])`

## Examples
```erlang
% Simple output
-export([main/0]).
main() -> io:fwrite("Hello, World!~n").
```

```erlang
% Function with parameters (using helper function)
-export([main/0, greet/1]).
main() -> greet("Alice").
greet(Name) -> io:format("Hello, ~s!~n", [Name]).
```

```erlang
% Pattern matching
-export([main/0, calculate/2]).
main() -> 
    Result = calculate(add, {5, 10}),
    io:format("Result: ~p~n", [Result]).
calculate(add, {A, B}) -> A + B;
calculate(multiply, {A, B}) -> A * B.
```

```erlang
% List processing
-export([main/0, sum_squares/1]).
main() ->
    Numbers = [1, 2, 3, 4, 5],
    Sum = sum_squares(Numbers),
    io:format("Sum of squares: ~p~n", [Sum]).
sum_squares(Numbers) ->
    Squared = [X*X || X <- Numbers],
    lists:sum(Squared).
```

```erlang
% Recursion
-export([main/0, factorial/1]).
main() ->
    Result = factorial(5),
    io:format("Factorial of 5: ~p~n", [Result]).
factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N-1).
```

```erlang
% Multiple functions
-export([main/0, double/1, triple/1]).
main() ->
    io:format("Double 5: ~p~n", [double(5)]),
    io:format("Triple 5: ~p~n", [triple(5)]).
double(X) -> X * 2.
triple(X) -> X * 3.
```

```erlang
% Using guards
-export([main/0, absolute/1]).
main() ->
    io:format("Absolute of -5: ~p~n", [absolute(-5)]),
    io:format("Absolute of 5: ~p~n", [absolute(5)]).
absolute(X) when X >= 0 -> X;
absolute(X) when X < 0 -> -X.
```

```erlang
% List comprehensions
-export([main/0, evens/1]).
main() ->
    Numbers = [1, 2, 3, 4, 5, 6],
    EvenNumbers = evens(Numbers),
    io:format("Even numbers: ~p~n", [EvenNumbers]).
evens(Numbers) -> [X || X <- Numbers, X rem 2 =:= 0].
```

## Caveats
- Functions must be exported to be callable from command line
- Erlang uses `~n` for newlines in format strings
- Variables are single-assignment (immutable)
- Pattern matching is exhaustive - all cases must be covered
- Function clauses are separated by semicolons (`;`), last clause ends with period (`.`)
- Guards use `when` keyword
- List comprehensions use `||` syntax
- The main function should be exported and callable via `-s module function`

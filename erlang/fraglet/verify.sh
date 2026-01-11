#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/erlang:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello, World!" <<'EOF'
-export([main/0]).
main() -> io:fwrite("Hello, World!~n").
EOF

# Example 2: Function with parameters
verify_fraglet "Hello, Alice" <<'EOF'
-export([main/0, greet/1]).
main() -> greet("Alice").
greet(Name) -> io:format("Hello, ~s!~n", [Name]).
EOF

# Example 3: Pattern matching
verify_fraglet "Result: 15" <<'EOF'
-export([main/0, calculate/2]).
main() -> 
    Result = calculate(add, {5, 10}),
    io:format("Result: ~p~n", [Result]).
calculate(add, {A, B}) -> A + B;
calculate(multiply, {A, B}) -> A * B.
EOF

# Example 4: List processing
verify_fraglet "Sum of squares:" <<'EOF'
-export([main/0, sum_squares/1]).
main() ->
    Numbers = [1, 2, 3, 4, 5],
    Sum = sum_squares(Numbers),
    io:format("Sum of squares: ~p~n", [Sum]).
sum_squares(Numbers) ->
    Squared = [X*X || X <- Numbers],
    lists:sum(Squared).
EOF

# Example 5: Recursion
verify_fraglet "Factorial of 5:" <<'EOF'
-export([main/0, factorial/1]).
main() ->
    Result = factorial(5),
    io:format("Factorial of 5: ~p~n", [Result]).
factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N-1).
EOF

# Example 6: Multiple functions
verify_fraglet "Double 5:" <<'EOF'
-export([main/0, double/1, triple/1]).
main() ->
    io:format("Double 5: ~p~n", [double(5)]),
    io:format("Triple 5: ~p~n", [triple(5)]).
double(X) -> X * 2.
triple(X) -> X * 3.
EOF

# Example 7: Using guards
verify_fraglet "Absolute of -5:" <<'EOF'
-export([main/0, absolute/1]).
main() ->
    io:format("Absolute of -5: ~p~n", [absolute(-5)]),
    io:format("Absolute of 5: ~p~n", [absolute(5)]).
absolute(X) when X >= 0 -> X;
absolute(X) when X < 0 -> -X.
EOF

# Example 8: List comprehensions
verify_fraglet "Even numbers:" <<'EOF'
-export([main/0, evens/1]).
main() ->
    Numbers = [1, 2, 3, 4, 5, 6],
    EvenNumbers = evens(Numbers),
    io:format("Even numbers: ~p~n", [EvenNumbers]).
evens(Numbers) -> [X || X <- Numbers, X rem 2 =:= 0].
EOF

echo "✓ All tests passed"

#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/mercury:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello from fragment!" <<'EOF'
main(!IO) :-
    io.write_string("Hello from fragment!\n", !IO).
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
main(!IO) :-
    A = 5,
    B = 10,
    Sum = A + B,
    io.write_string("Sum: ", !IO),
    io.write_int(Sum, !IO),
    io.nl(!IO).
EOF

# Example 3: Helper predicates
verify_fraglet "5 + 10 = 15" <<'EOF'
:- pred add(int::in, int::in, int::out) is det.
add(X, Y, Sum) :-
    Sum = X + Y.

main(!IO) :-
    add(5, 10, Result),
    io.write_string("5 + 10 = ", !IO),
    io.write_int(Result, !IO),
    io.nl(!IO).
EOF

# Example 4: Pattern matching with lists
verify_fraglet "Sum:" <<'EOF'
:- pred sum_list(list(int)::in, int::out) is det.
sum_list([], 0).
sum_list([Head | Tail], Sum) :-
    sum_list(Tail, TailSum),
    Sum = Head + TailSum.

main(!IO) :-
    Numbers = [1, 2, 3, 4, 5],
    sum_list(Numbers, Total),
    io.write_string("Sum: ", !IO),
    io.write_int(Total, !IO),
    io.nl(!IO).
EOF

# Example 5: String operations
verify_fraglet "Hello World!" <<'EOF'
main(!IO) :-
    S = "Hello",
    string.append(S, " World!", T),
    io.write_string(T, !IO),
    io.nl(!IO),
    string.length(T, Len),
    io.write_string("Length: ", !IO),
    io.write_int(Len, !IO),
    io.nl(!IO).
EOF

# Example 6: Conditionals
verify_fraglet "Absolute of -5: 5" <<'EOF'
:- pred absolute(int::in, int::out) is det.
absolute(X, Y) :-
    ( X >= 0 ->
        Y = X
    ;
        Y = -X
    ).

main(!IO) :-
    absolute(-5, Result),
    io.write_string("Absolute of -5: ", !IO),
    io.write_int(Result, !IO),
    io.nl(!IO).
EOF

# Example 7: Higher-order predicates
verify_fraglet "Doubled:" <<'EOF'
:- pred double(int::in, int::out) is det.
double(X, Y) :-
    Y = X * 2.

main(!IO) :-
    Numbers = [1, 2, 3, 4, 5],
    list.map(double, Numbers, Doubled),
    io.write_string("Doubled: ", !IO),
    io.print(Doubled, !IO),
    io.nl(!IO).
EOF

echo "✓ All tests passed"

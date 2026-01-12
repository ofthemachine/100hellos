# Mercury Fraglet Guide

## Language Version
Mercury compiler (mmc) - latest available in Alpine

## Execution Model
- Compiled language using `mmc` (Mercury compiler)
- Code is compiled to a binary, then executed
- Standard Mercury execution model with `main(io::di, io::uo)` predicate

## Key Characteristics
- Pure logic programming language with static typing
- Strong type system with type inference
- Mode system: specifies input/output modes for predicates (e.g., `di` = destructive input, `uo` = unique output)
- Determinism system: specifies whether predicates are `det` (deterministic), `semidet` (semi-deterministic), `nondet` (non-deterministic), or `multi` (multi-solution)
- State variables (`!IO`) for threading I/O state
- Module system with interface and implementation sections
- Pattern matching
- Higher-order predicates
- Case-sensitive
- Predicates end with a period (`.`)
- Uses `:-` for declarations and rules

## Fragment Authoring
Write valid Mercury code. Your fragment can define helper predicates and the `main` predicate. Your fragment will be compiled and executed.

**Important**: Your fragment must include the `main(!IO) :-` predicate definition, as it replaces the entire implementation section.

## Available Libraries
The template includes the following standard modules (already imported):
- `io` - I/O operations:
  - `io.write_string(String, !IO)` - Write a string
  - `io.write(Value, !IO)` - Write a value
  - `io.nl(!IO)` - Write a newline
  - `io.print(Value, !IO)` - Print a value
  - `io.format(FormatString, Args, !IO)` - Formatted output
- `int` - Integer operations (arithmetic operators like `+`, `-`, `*`, `/`)
- `list` - List operations (`list.map`, `list.filter`, `list.foldl`, etc.)
- `string` - String operations (`string.append`, `string.length`, etc.)

Additional modules can be imported in the interface section if needed:
- `float` - Floating-point operations
- `math` - Mathematical functions
- `solutions` - Solution handling for non-deterministic predicates
- And many more from the Mercury standard library

## Common Patterns
- Output: `io.write_string("Hello World!\n", !IO)`
- Multiple statements: Use `,` to sequence goals: `Goal1, Goal2, Goal3`
- Variables: `X = 5` (unification)
- Predicates: `predicate_name(Arg1, Arg2, !IO) :- Body.`
- Pattern matching: `[Head | Tail]` for lists, `{X, Y}` for tuples
- Conditionals: `( Condition -> Then ; Else )`
- Loops: Use recursion or higher-order predicates like `list.foldl`
- State variables: `!IO` for I/O state, `!State` for custom state
- List operations: `list.map`, `list.filter`, `list.foldl`, `list.length`
- String concatenation: `string.append(String1, String2, Result)`

## Examples
```mercury
% Simple output
main(!IO) :-
    io.write_string("Hello from fragment!\n", !IO).

% Variables and calculations
main(!IO) :-
    A = 5,
    B = 10,
    Sum = A + B,
    io.write_string("Sum: ", !IO),
    io.write_int(Sum, !IO),
    io.nl(!IO).

% Helper predicates
:- pred add(int::in, int::in, int::out) is det.
add(X, Y, Sum) :-
    Sum = X + Y.

main(!IO) :-
    add(5, 10, Result),
    io.write_string("5 + 10 = ", !IO),
    io.write_int(Result, !IO),
    io.nl(!IO).

% Pattern matching with lists
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

% String operations
main(!IO) :-
    S = "Hello",
    string.append(S, " World!", T),
    io.write_string(T, !IO),
    io.nl(!IO),
    string.length(T, Len),
    io.write_string("Length: ", !IO),
    io.write_int(Len, !IO),
    io.nl(!IO).

% Conditionals
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

% Higher-order predicates
main(!IO) :-
    Numbers = [1, 2, 3, 4, 5],
    list.map(double, Numbers, Doubled),
    io.write_string("Doubled: ", !IO),
    io.print(Doubled, !IO),
    io.nl(!IO).

:- pred double(int::in, int::out) is det.
double(X, Y) :-
    Y = X * 2.
```

## Caveats
- Fragments must be valid Mercury code that compiles
- Remember that Mercury is case-sensitive
- All predicates must end with a period (`.`)
- State variables (`!IO`) must be threaded through all I/O operations
- Mode declarations are required for predicates (though often inferred)
- Determinism declarations are required (though often inferred)
- Use `=` for unification (not assignment)
- String concatenation uses `string.append`, not `++`
- Use `io.write_int` for integers, `io.write_string` for strings
- Pattern matching uses `[Head | Tail]` for lists
- Conditionals use `( Condition -> Then ; Else )` syntax
- Helper predicates must be defined before they are used (or declared in interface)
- The `main` predicate must have mode `main(io::di, io::uo) is det.`

# Prolog Fraglet Guide

## Language Version
SWI-Prolog

## Execution Model
- Logic programming, runs goals/queries
- Each statement executes immediately as a goal (like typing at the Prolog prompt)
- Output goes to stdout
- Runs in quiet mode

## Key Characteristics
- Statements must end with a period (`.`)
- Case-sensitive: Variables start with uppercase, atoms/constants with lowercase
- Predicates: `predicate_name(arg1, arg2).`
- Rules: `head :- body.` (head is true if body is true)
- Queries: `?- goal.` (asks Prolog to find solutions)

## Fragment Authoring
Fragments should be valid Prolog goals or statements. Code runs as if typed at the Prolog toplevel. Each statement executes as a goal.

## Working with State
- Use `assertz/1` (or `asserta/1`) to add facts and rules before querying them
- Remove facts with `retract/1` or clear an entire predicate with `retractall/1`
- Finish with `halt.` to exit explicitly once your goals are complete

## Common Patterns
- Output: `write("Hello World!").`
- Facts: `assertz(parent(john, mary)).`
- Rules: `assertz((grandparent(X, Y) :- parent(X, Z), parent(Z, Y))).`
- Queries: `parent(john, mary).`
- Lists: `member(X, [X|_]).`
- Arithmetic: `X is 5 + 3.`

## Examples
```prolog
% Simple output
write("Hello, World!"), nl.

% Define facts
assertz(likes(alice, chocolate)).
assertz(likes(bob, ice_cream)).

% Query
likes(alice, What), write(What), nl.

% List processing
member(X, [1, 2, 3, 4, 5]), X > 3, write(X), nl.
```

## Caveats
- Prolog will stay in the toplevel after execution unless you call `halt.`
- State persists during execution, so `assertz` facts remain available
- Each run starts fresh—no state persists between runs

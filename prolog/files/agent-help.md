# Prolog Language Guide

## Version
SWI-Prolog (compiled from source)

## Execution Context
Code runs in SWI-Prolog's quiet mode and each statement is executed immediately as a goal (as if typed at the toplevel). Output goes to stdout.

### Working with Stateful Code
- Use `assertz/1` (or `asserta/1`) to add facts and rules before querying them.
- Remove facts with `retract/1` or clear an entire predicate with `retractall/1`.
- Finish with `halt.` to exit explicitly once your goals are complete (otherwise Prolog stays in the toplevel).

## Language Fundamentals

Prolog is a logic programming language based on formal logic. Code consists of:

- **Facts**: Declarations about the world
- **Rules**: Logical relationships between facts
- **Queries**: Questions that Prolog answers by searching for solutions

## Syntax Rules

- **Statements end with a period** (`.`)
- **Case-sensitive**: Variables start with uppercase, atoms/constants with lowercase
- **Predicates**: `predicate_name(arg1, arg2).`
- **Rules**: `head :- body.` (head is true if body is true)
- **Queries**: `?- goal.` (asks Prolog to find solutions)

## Writing Code

### Output
```prolog
write("Hello World!").
```

### Facts (runtime)
```prolog
assertz(parent(john, mary)).
assertz(parent(mary, bob)).
assertz(likes(alice, chocolate)).
```

### Rules (runtime)
```prolog
assertz((grandparent(X, Y) :- parent(X, Z), parent(Z, Y))).
assertz((ancestor(X, Y) :- parent(X, Y))).
assertz((ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y))).
```

### Queries and Goals
```prolog
parent(john, mary).
grandparent(X, bob).
likes(alice, What).
findall(X, ancestor(X, luna), Ancestors).
```

### Lists
```prolog
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).
```

### Arithmetic
```prolog
X is 5 + 3.
Y is 10 * 2.
```

## Common Patterns

- **Recursion**: Prolog excels at recursive definitions
- **Dynamic knowledge**: Build predicates on the fly with `assertz/1`
- **Backtracking**: Prolog automatically searches for all solutions
- **Unification**: Variables unify with matching terms
- **Pattern matching**: Use different clause heads for different cases

## What You Can Do

- Define knowledge bases with facts and rules
- Query relationships and find all solutions
- Perform computations and transformations
- Work with lists, trees, and recursive structures
- Solve constraint problems through logical inference

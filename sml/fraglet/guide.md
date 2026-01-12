# Standard ML (SML) Fraglet Guide

## Language Version
Poly/ML 5.x (Standard ML implementation)

## Execution Model
- Interpreted via Poly/ML REPL
- Code executes at the top level
- Expressions and declarations run immediately
- Uses `poly --quiet` to suppress startup messages

## Key Characteristics
- **Strong static typing** with Hindley-Milner type inference
- **Functional programming** with immutable data structures by default
- **Pattern matching** for elegant control flow
- **Case-sensitive** identifiers
- **Semicolon-terminated** statements and declarations
- **Top-level bindings** - functions and values can be defined at module level

## Fragment Authoring
Write valid SML expressions or declarations. Your fragment becomes the script body. Code executes at the top level, so expressions run immediately. You can define functions, values, and use pattern matching.

## Available Libraries
Standard ML Basis Library is available. Poly/ML provides additional libraries for I/O, system interaction, and more.

## Common Patterns

### Print Output
```sml
print "Hello, World!\n";
```

### Variable Bindings
```sml
val x = 42;
val name = "Alice";
print (name ^ "\n");
```

### Function Definitions
```sml
fun greet name = "Hello, " ^ name ^ "!\n";
print (greet "World");
```

### Pattern Matching
```sml
fun factorial 0 = 1
  | factorial n = n * factorial (n - 1);
print ("Factorial of 5: " ^ Int.toString (factorial 5) ^ "\n");
```

### Lists and Higher-Order Functions
```sml
val numbers = [1, 2, 3, 4, 5];
val sum = foldl (op +) 0 numbers;
print ("Sum: " ^ Int.toString sum ^ "\n");
```

### Recursive Functions
```sml
fun length [] = 0
  | length (_::xs) = 1 + length xs;
print ("Length: " ^ Int.toString (length [1,2,3]) ^ "\n");
```

### Conditional Expressions
```sml
fun max a b = if a > b then a else b;
print ("Max of 5 and 10: " ^ Int.toString (max 5 10) ^ "\n");
```

## Examples

```sml
# Simple output
print "Hello, World!\n";

# Variables and calculations
val a = 5;
val b = 10;
print ("Sum: " ^ Int.toString (a + b) ^ "\n");

# Function definition
fun add x y = x + y;
print ("5 + 10 = " ^ Int.toString (add 5 10) ^ "\n");

# Pattern matching
fun factorial 0 = 1
  | factorial n = n * factorial (n - 1);
print ("Factorial of 5: " ^ Int.toString (factorial 5) ^ "\n");

# Lists and higher-order functions
val numbers = [1, 2, 3, 4, 5];
val sum = foldl (op +) 0 numbers;
print ("Sum: " ^ Int.toString sum ^ "\n");

# List comprehensions (using map)
val squares = map (fn x => x * x) [1, 2, 3, 4, 5];
print ("Squares: " ^ String.concatWith ", " (map Int.toString squares) ^ "\n");

# String operations
val s = "Hello";
val t = s ^ " World!";
print (t ^ "\n");
print ("Length: " ^ Int.toString (String.size t) ^ "\n");

# Guards and case expressions
fun absolute x = if x >= 0 then x else ~x;
print ("Absolute of ~5: " ^ Int.toString (absolute (~5)) ^ "\n");
```

## Caveats and Limitations

- **Semicolons required**: Top-level expressions must end with semicolons
- **Type inference**: SML infers types, but type errors will prevent execution
- **Immutable by default**: Variables are immutable (use `val` bindings)
- **String concatenation**: Use `^` operator, not `+`
- **Integer negation**: Use `~` prefix, not `-` (e.g., `~5` not `-5`)
- **Print formatting**: Use `Int.toString`, `Real.toString`, etc. for number-to-string conversion
- **Poly/ML specific**: Some features may be Poly/ML-specific rather than pure SML

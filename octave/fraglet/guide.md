# Octave Fraglet Guide

## Language Version
GNU Octave 8.x (MATLAB-compatible)

## Execution Model
- Interpreted language, runs via Octave interpreter
- Code executes at the top level
- MATLAB-compatible syntax and behavior
- Code runs sequentially from top to bottom

## Key Characteristics
- Matrix-oriented programming (matrices are first-class)
- Case-sensitive
- Dynamic typing
- MATLAB-compatible syntax

## Fragment Authoring
Write valid Octave/MATLAB statements or expressions. Your fragment becomes the script body. Code runs at the top level of the script.

## Available Packages
Standard Octave library is available. No additional packages are pre-installed. Package installation is possible but not typical for fraglet contexts (installs are ephemeral and add latency).

## Common Patterns
- Print: `printf("message\n")` or `disp("message")`
- Variables: `x = 10` or `y = [1, 2, 3]`
- Functions: `function result = name(x) result = x * 2; end`
- Matrices: `[1, 2, 3; 4, 5, 6]` or `1:10`
- Element-wise operations: `A .* B` (note the dot)
- Matrix operations: `A * B` (matrix multiplication)

## Examples
```octave
# Simple output
printf("Hello, World!\n");

# Matrix operations and linear algebra
A = [1, 2, 3; 4, 5, 6; 7, 8, 9];
B = A * A;
printf("Matrix product sum: %d\n", sum(B(:)));

# Element-wise operations (note the dot operator)
x = 1:5;
y = x .^ 2;
printf("Sum of squares: %d\n", sum(y));

# Matrix indexing and slicing
M = [1, 2, 3; 4, 5, 6; 7, 8, 9];
printf("First row: %s\n", mat2str(M(1, :)));
printf("Diagonal: %s\n", mat2str(diag(M)));

# Built-in mathematical functions
angles = [0, pi/4, pi/2];
sines = sin(angles);
printf("Sines: %s\n", mat2str(sines, 3));
```

## Caveats
- Fragments must be valid Octave/MATLAB that executes without errors
- Variables are scoped to the script level
- Use `printf()` with `\n` for output, or `disp()` for simple messages
- Remember that Octave is matrix-oriented - many operations work on matrices
- Element-wise operations require the dot operator (`.^`, `.*`, `./`)
- Make fragments idempotent—repeated runs should succeed without manual cleanup


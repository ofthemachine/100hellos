# Pascal Fraglet Guide

## Language Version
Free Pascal (FPC) 3.2.2

## Execution Model
- Compiled language using Free Pascal Compiler (FPC)
- Code is compiled to a binary, then executed
- Standard Pascal execution model with a program block

## Key Characteristics
- Statically typed
- Case-insensitive
- Requires explicit compilation step
- Uses Free Pascal Compiler (FPC)
- Supports both procedural and object-oriented programming

## Fragment Authoring
Write valid Pascal code blocks. Your fragment becomes the main program body. Your fragment will be compiled and executed.

Fragments must include the `begin` and `end.` statements, along with all the code you want to execute.

## Available Units
The template includes:
- `crt` - C runtime library (basic I/O operations)

Standard Pascal units are available:
- `crt` - Console I/O (writeln, readln, etc.)
- `sysutils` - System utilities (string functions, date/time)
- `math` - Mathematical functions (sin, cos, sqrt, pow)
- `strutils` - String utilities (string manipulation functions)

## Common Patterns
- Output: `writeln('message');`
- Variables: `var x: integer;` or `x: integer = 10;`
- Procedures: `procedure Name; begin ... end;`
- Functions: `function Add(a, b: integer): integer; begin Add := a + b; end;`
- Arrays: `arr: array[1..10] of integer;`
- Loops: `for i := 1 to 10 do begin ... end;`
- Conditionals: `if x > 0 then begin ... end;`

## Examples
```pascal
// Simple output
begin
  writeln('Hello from fragment!');
end.

// Variables and calculations
var
  a, b: integer;
begin
  a := 5;
  b := 10;
  writeln('Sum: ', a + b);
end.

// Loops
var
  i: integer;
begin
  for i := 1 to 5 do
    writeln('Count: ', i);
end.

// Arrays
var
  numbers: array[1..5] of integer = (1, 2, 3, 4, 5);
  sum, i: integer;
begin
  sum := 0;
  for i := 1 to 5 do
    sum := sum + numbers[i];
  writeln('Array sum: ', sum);
end.
```

## Caveats
- Fragments must be valid Pascal code that compiles
- Pascal uses single quotes for strings: `'string'`
- Variables must be declared in a `var` block before the `begin` block
- The code is compiled fresh each time, so compilation errors will fail execution
- Pascal is case-insensitive
- Statement terminators (`;`) are required
- Fragments must include the complete `begin...end.` block structure
- If you need variables, declare them in a `var` block before `begin`

# Ada Fraglet Guide

## Language Version
Ada (GNAT compiler, Alpine Linux)

## Execution Model
- Compiled language using GNAT (GNU Ada Translator)
- Code is compiled to a binary using `gnatmake`, then executed
- Build script compiles `hello.adb` to `hello` binary, then runs it
- Standard Ada execution model with a main procedure

## Key Characteristics
- Statically typed
- Case-insensitive keywords (but case-sensitive identifiers)
- Strong typing with type safety
- Requires explicit compilation step
- Uses GNAT compiler (GCC-based Ada compiler)

## Fragment Authoring
Fragments should be valid Ada statements. They are injected into the main procedure, replacing the match marker. The fragment code will be compiled and executed.

Fragments are injected into the `Put_Line` call, so you can replace the string argument or add additional statements before/after the Put_Line call.

## Available Packages
The template includes:
- `Ada.Text_IO` - Text input/output operations (Put_Line, Get_Line, etc.)

Standard Ada library packages are available:
- `Ada.Text_IO` - Text I/O
- `Ada.Integer_Text_IO` - Integer I/O
- `Ada.Float_Text_IO` - Float I/O
- `Ada.Strings` - String manipulation
- `Ada.Numerics` - Mathematical functions

## Common Patterns
- Output: `Put_Line ("message");`
- Variables: `X : Integer := 10;`
- Procedures: `procedure Name is begin ... end Name;`
- Functions: `function Add (A, B : Integer) return Integer is begin return A + B; end Add;`
- Arrays: `Arr : array (1..10) of Integer;`
- Loops: `for I in 1..10 loop ... end loop;`
- Conditionals: `if X > 0 then ... end if;`

## Examples
```ada
-- Simple output
Put_Line ("Hello from fragment!");

-- Variables and calculations
A : Integer := 5;
B : Integer := 10;
Put_Line ("Sum: " & Integer'Image (A + B));

-- Loops
for I in 1..5 loop
    Put_Line ("Count: " & Integer'Image (I));
end loop;

-- Arrays
Numbers : array (1..5) of Integer := (1, 2, 3, 4, 5);
Sum : Integer := 0;
for I in Numbers'Range loop
    Sum := Sum + Numbers (I);
end loop;
Put_Line ("Array sum: " & Integer'Image (Sum));
```

## Caveats
- Fragments must be valid Ada code that compiles
- Remember Ada uses `&` for string concatenation
- Use `Integer'Image` or `Float'Image` to convert numbers to strings
- Variables must be declared before use
- The code is compiled fresh each time, so compilation errors will fail execution
- Ada is case-insensitive for keywords but case-sensitive for identifiers
- Statement terminators (`;`) are required

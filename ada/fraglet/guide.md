# Ada Fraglet Guide

## Language Version
Ada (GNAT compiler, Alpine Linux)

## Execution Model
- Compiled language using GNAT (GNU Ada Translator)
- Code is compiled to a binary using `gnatmake`, then executed
- Standard Ada execution model with a main procedure

## Key Characteristics
- Statically typed
- Case-insensitive keywords (but case-sensitive identifiers)
- Strong typing with type safety
- Requires explicit compilation step
- Uses GNAT compiler (GCC-based Ada compiler)

## Fragment Authoring
Write a complete Ada program. Your fragment must define `procedure Fraglet` as the main entry point. Include any `with` imports you need.

## Available Packages
Standard Ada library packages are available:
- `Ada.Text_IO` - Text I/O (Put_Line, Get_Line, End_Of_File, etc.)
- `Ada.Characters.Handling` - Character/string case (e.g. `To_Upper`)
- `Ada.Command_Line` - Command-line arguments (`Argument_Count`, `Argument (I)`)
- `Ada.Integer_Text_IO`, `Ada.Strings`, `Ada.Numerics`, etc.

## Common Patterns
- Output: `Put_Line ("message");`
- Variables: `X : Integer := 10;`
- Procedures: `procedure Name is begin ... end Name;`
- Functions: `function Add (A, B : Integer) return Integer is begin return A + B; end Add;`
- Arrays: `Arr : array (1..10) of Integer;`
- Loops: `for I in 1..10 loop ... end loop;`
- Conditionals: `if X > 0 then ... end if;`
- Stdin: `Get_Line (Line, Last)` in a `while not End_Of_File loop`; use `Ada.Characters.Handling.To_Upper` for uppercase.
- Command-line args: `Ada.Command_Line.Argument_Count`, `Ada.Command_Line.Argument (I)` (I from 1 to Argument_Count).

## Examples
```ada
-- Simple output
with Ada.Text_IO; use Ada.Text_IO;
procedure Fraglet is
begin
  Put_Line ("Hello from fragment!");
end Fraglet;

-- With local variables
with Ada.Text_IO; use Ada.Text_IO;
procedure Fraglet is
  A : Integer := 5;
  B : Integer := 10;
begin
  Put_Line ("Sum: " & Integer'Image (A + B));
end Fraglet;

-- Reading stdin
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Handling;
procedure Fraglet is
  Line : String (1 .. 1024);
  Last : Natural;
begin
  while not End_Of_File loop
    Get_Line (Line, Last);
    Put_Line (Ada.Characters.Handling.To_Upper (Line (1 .. Last)));
  end loop;
end Fraglet;

-- Command-line args
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;
procedure Fraglet is
begin
  for I in 1 .. Ada.Command_Line.Argument_Count loop
    Put_Line (Ada.Command_Line.Argument (I));
  end loop;
end Fraglet;
```

## Caveats
- Fragments must be valid Ada code that compiles
- Remember Ada uses `&` for string concatenation
- Use `Integer'Image` or `Float'Image` to convert numbers to strings
- Variables must be declared before use
- The code is compiled fresh each time, so compilation errors will fail execution
- Ada is case-insensitive for keywords but case-sensitive for identifiers
- Statement terminators (`;`) are required

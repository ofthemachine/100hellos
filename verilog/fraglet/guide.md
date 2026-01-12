# Verilog Fraglet Guide

## Language Version
Verilog (Icarus Verilog - iverilog)

## Execution Model
- Hardware description language that must be compiled/simulated
- Code is compiled with `iverilog`, then executed as a simulation
- Uses an event-driven simulation model

## Key Characteristics
- Hardware description language (HDL)
- Case-sensitive
- Module-based structure
- Event-driven simulation
- Procedural blocks (`initial`, `always`)
- System tasks (`$display`, `$finish`, etc.)

## Fragment Authoring
Write valid Verilog code. Your fragment must include a complete `initial begin...end` block. You can declare variables at the module level and use them in the initial block.

**Important**: 
- Fragments must include a complete `initial begin...end` block
- Must include `$finish;` at the end to properly terminate the simulation, otherwise the simulation may hang
- Variables can be declared at the module level (before the initial block) or inside the initial block using `reg` or `integer` types

## Available System Tasks
Common Verilog system tasks:
- **$display**: Print formatted output (like printf)
  - `$display("format", args);`
  - `$display("Hello, World!");`
- **$finish**: Terminate simulation
  - `$finish;` (required at end of fragments)
- **$write**: Print without newline
  - `$write("text");`
- **$monitor**: Monitor signal changes
  - `$monitor("format", signals);`

## Common Patterns
- Print: `$display("message");`
- Variables: Declare at module level: `integer x;` then assign in initial block: `x = 10;`
- Arithmetic: `integer sum;` (module level), then `sum = a + b;` (in initial block)
- Loops: `integer i;` (module level), then `for (i = 0; i < 10; i = i + 1) begin ... end` (in initial block)
- Conditionals: `if (condition) begin ... end else begin ... end`

## Examples
```verilog
// Simple output
initial begin
    $display("Hello from fragment!");
    $finish;
end

// Variables and calculations (module-level declarations)
integer a, b, sum;
initial begin
    a = 5;
    b = 10;
    sum = a + b;
    $display("Sum: %d", sum);
    $finish;
end

// Loops
integer i;
initial begin
    for (i = 1; i <= 5; i = i + 1) begin
        $display("Count: %d", i);
    end
    $finish;
end

// Arrays and iteration
integer numbers[0:4];
integer i;
initial begin
    for (i = 0; i < 5; i = i + 1) begin
        numbers[i] = i * 2;
        $display("numbers[%d] = %d", i, numbers[i]);
    end
    $finish;
end

// Conditionals
integer value;
initial begin
    value = 42;
    if (value > 50) begin
        $display("Value is greater than 50");
    end else begin
        $display("Value is %d", value);
    end
    $finish;
end
```

## Caveats
- Fragments must be valid Verilog that compiles without errors
- **Must include a complete `initial begin...end` block**
- **Must include `$finish;` at the end** or simulation may hang
- Variables should be declared at the module level (before the initial block) for best compatibility with iverilog
- Variable assignments happen inside the initial block
- Integer arithmetic uses `integer` type
- For loops require variable declaration at module level: `integer i;` before the initial block
- Format specifiers: `%d` for integers, `%s` for strings, `%b` for binary, `%h` for hex
- The code is compiled fresh each time, so compilation errors will fail execution
- Verilog is a hardware description language - fragments run in simulation, not as traditional software

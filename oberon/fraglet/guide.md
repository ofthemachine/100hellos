# Oberon Fraglet Guide

## Language Version
Oberon (oberonc: JVM-based compiler)

## Execution Model
- Compiled language: source (`.mod`) is compiled to JVM bytecode, then executed
- Your fragment is the **entire module**: it replaces the whole module between the injection markers
- Use **MODULE Fraglet** with **BEGIN** … **END Fraglet.** so the container runner can invoke the compiled main class

## Key Characteristics
- Wirth-family language: structured, minimal syntax
- Case-sensitive; semicolons separate statements
- Module-based: each compilation unit is a MODULE with optional IMPORT
- Procedures and variables at module level
- No nested procedure definitions; procedures are declared in the module body before BEGIN

## Fragment Authoring
Write a **complete** Oberon module. The fraglet is the full module: MODULE name; optional IMPORT; optional declarations; BEGIN … END name. The container compiles `hello-world.mod` and runs the module’s main entry; the module name must be **Fraglet** to match the runner.

## Available Libraries
- **Out**: `Out.String(s)`, `Out.Int(i, n)`, `Out.Ln` for output
- Standard Oberon modules provided by oberonc runtime

## Common Patterns
- Print: `Out.String("message"); Out.Ln`
- Print integer: `Out.Int(42, 0); Out.Ln`
- Variables: `VAR x: INTEGER;` in declaration part, then `x := 5;` in body
- Procedures: declare in declaration part, define before BEGIN
- Loops: `WHILE condition DO … END`
- Conditionals: `IF condition THEN … ELSE … END`

## Examples

```oberon
MODULE Fraglet;
  IMPORT Out;
BEGIN
  Out.String("Hello, World!");
  Out.Ln
END Fraglet.
```

```oberon
MODULE Fraglet;
  IMPORT Out;
  VAR a, b: INTEGER;
BEGIN
  a := 5;
  b := 10;
  Out.String("Sum: ");
  Out.Int(a + b, 0);
  Out.Ln
END Fraglet.
```

```oberon
MODULE Fraglet;
  IMPORT Out;
  VAR sum, i: INTEGER;
BEGIN
  sum := 0;
  i := 1;
  WHILE i <= 5 DO
    sum := sum + i;
    i := i + 1
  END;
  Out.String("Sum 1..5: ");
  Out.Int(sum, 0);
  Out.Ln
END Fraglet.
```

```oberon
MODULE Fraglet;
  IMPORT Out;
  PROCEDURE Double(x: INTEGER): INTEGER;
  BEGIN
    RETURN x * 2
  END Double;
BEGIN
  Out.String("5 * 2 = ");
  Out.Int(Double(5), 0);
  Out.Ln
END Fraglet.
```

## Notes
- Module name must be **Fraglet** so the container can run the compiled program
- Procedure declarations go between the IMPORT section and BEGIN
- Semicolons between statements; no semicolon after END

# ash Fraglet Guide

## Code format (what you send to run)

- **Fragment only.** Your code replaces the template line that contains `Hello World!` and can be one or more lines of valid ash.
- **MCP run tool:** code-only; no stdin, no args. `$1`, `$*`, and `read` are empty/unavailable. Use literals and variables. For CLI with stdin/args, see Caveats.

## Minimal fragment (copy and adapt)

```ash
echo "Hello from fragment!"
```

## Language Version
ash (Almquist Shell) - POSIX-compliant shell

## Execution Model
- Interpreted shell script; runs line-by-line. Uses shebang `#!/usr/bin/env ash` (Alpine/busybox).

## Key Characteristics
- POSIX-compliant shell (subset of sh)
- Case-sensitive; variables: `VAR=value` (no spaces around `=`)
- Command substitution: `` `command` `` or `$(command)`; interpolation: `"$VAR"`
- No arrays (unlike bash); limited built-ins

## Fragment Authoring
Write valid ash commands. Your fragment is injected at the point where `Hello World!` appears (replace the echo or add more commands).

## Available Commands
Standard POSIX utilities are available:
- `echo` - Print text
- `printf` - Formatted output
- `test` / `[` - Conditional tests
- `if`, `while`, `for` - Control structures
- `grep`, `sed`, `awk` - Text processing (if installed)
- Standard Unix utilities

## Common Patterns
- Output: `echo "message"` or `printf "%s\n" "message"`
- Variables: `NAME="value"` and `echo "$NAME"`
- Conditionals: `if [ condition ]; then ... fi`
- Loops: `for i in 1 2 3; do echo "$i"; done`
- Command substitution: `RESULT=$(command)`
- Arithmetic: `expr 1 + 2` or `$((1 + 2))` (if supported)

## Examples
```ash
# Simple output
echo "Hello from fragment!"

# Variables
NAME="Alice"
echo "Hello, $NAME!"

# Arithmetic
A=5
B=10
SUM=$((A + B))
echo "Sum: $SUM"

# Loops
for i in 1 2 3 4 5; do
    echo "Count: $i"
done

# Conditionals
if [ "$1" = "test" ]; then
    echo "Testing mode"
else
    echo "Normal mode"
fi

# Command substitution
DATE=$(date)
echo "Current date: $DATE"
```

## Caveats
- **MCP:** No stdin or args; use literals/variables. CLI: stdin and `$*` work when running via fragletc with a pipe or args.
- ash is a minimal shell - fewer features than bash
- No arrays (use space-separated strings instead)
- Limited arithmetic expansion (may need `expr`)
- Variable assignment: no spaces around `=`
- Use `[` for tests, not `[[` (bashism)
- Quote variables to prevent word splitting: `"$VAR"`
- Case-sensitive variable names
- Limited built-in string manipulation (may need external tools)

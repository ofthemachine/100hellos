# ash Fraglet Guide

## Language Version
ash (Almquist Shell) - POSIX-compliant shell

## Execution Model
- Interpreted shell script
- Code executes directly from source
- Scripts run line-by-line from top to bottom
- Uses shebang `#!/usr/bin/env ash` for execution (explicit - Alpine uses busybox)

## Key Characteristics
- POSIX-compliant shell (subset of sh)
- Case-sensitive
- Variables: `VAR=value` (no spaces around `=`)
- Command substitution: `` `command` `` or `$(command)`
- String interpolation: `"$VAR"` or `"${VAR}"`
- No arrays (unlike bash)
- Limited built-in features compared to bash

## Fragment Authoring
Write valid ash shell commands. Your fragment becomes the script body. The fragment code will execute as part of the shell script.

Fragments are injected at the point where `Hello World!` appears in the echo statement, so you can replace the echo argument or add additional commands.

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
- ash is a minimal shell - fewer features than bash
- No arrays (use space-separated strings instead)
- Limited arithmetic expansion (may need `expr`)
- Variable assignment: no spaces around `=`
- Use `[` for tests, not `[[` (bashism)
- Quote variables to prevent word splitting: `"$VAR"`
- Case-sensitive variable names
- Limited built-in string manipulation (may need external tools)

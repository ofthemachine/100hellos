# dash Fraglet Guide

## Language Version
dash (Debian Almquist Shell) - POSIX-compliant shell

## Execution Model
- Interpreted shell script
- Code executes directly from source
- Scripts run line-by-line from top to bottom
- Uses shebang `#!/usr/bin/env dash` for execution
- POSIX-compliant shell (minimal, fast)

## Key Characteristics
- POSIX-compliant shell (subset of bash features)
- Case-sensitive
- Variables: `VAR=value` (no spaces around `=`)
- Command substitution: `` `command` `` or `$(command)`
- String interpolation: `"$VAR"` or `"${VAR}"`
- Arithmetic expansion: `$((expression))`
- Pattern matching: `[ string = pattern ]` (POSIX `[`, not bash `[[`)

## Fragment Authoring
Write valid POSIX shell commands. Your fragment becomes the script body. The fragment code will execute as part of the shell script.

## Available Commands
Standard Unix utilities and POSIX shell built-ins are available:
- `echo` - Print text
- `printf` - Formatted output
- `test` / `[` - Conditional tests (POSIX-compliant)
- `if`, `while`, `for`, `until` - Control structures
- `grep`, `sed`, `awk` - Text processing (if installed)
- Standard Unix utilities

## Common Patterns
- Output: `echo "message"` or `printf "%s\n" "message"`
- Variables: `NAME="value"` and `echo "$NAME"`
- Conditionals: `if [ condition ]; then ... fi`
- Loops: `for i in 1 2 3 4 5; do echo "$i"; done`
- Command substitution: `RESULT=$(command)`
- Arithmetic: `$((A + B))`
- Functions: `function_name() { ... }`
- Here documents: `cat <<EOF ... EOF`

## Examples
```dash
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

# Functions
greet() {
    local name="$1"
    echo "Hello, $name!"
}

greet "World"

# Command substitution
DATE=$(date)
echo "Current date: $DATE"

# Multiple statements
echo "First line"
echo "Second line"
echo "Third line"

# Arithmetic in loops
for i in $(seq 1 5); do
    echo "Number: $i"
done

# Nested conditionals
if [ -n "$1" ]; then
    if [ "$1" = "hello" ]; then
        echo "Greeting received"
    else
        echo "Other argument: $1"
    fi
else
    echo "No argument provided"
fi
```

## Caveats
- Variable assignment: no spaces around `=`
- Use `[` for tests (POSIX-compliant), not `[[` (bash-specific)
- String comparison: use `=` not `==` in `[` tests
- Quote variables to prevent word splitting: `"$VAR"`
- No bash-style arrays (use space-separated strings or `$IFS`)
- No brace expansion like `{1..5}` (use `seq` or explicit lists)
- Arithmetic expansion: `$((expression))` (no `$` inside)
- Function definitions: `function_name() { ... }` (POSIX style)
- Use `local` keyword inside functions to avoid global variable pollution
- Dash is minimal - avoid bash-specific features

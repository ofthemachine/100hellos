# mksh Fraglet Guide

## Language Version
mksh (MirBSD Korn Shell) - Korn shell implementation

## Execution Model
- Interpreted shell script
- Code executes directly from source
- Scripts run line-by-line from top to bottom
- Uses shebang `#!/usr/bin/env mksh` for execution
- Compatible with POSIX shell and extends Korn shell features

## Key Characteristics
- Korn shell compatible (superset of Bourne Shell)
- Case-sensitive
- Variables: `VAR=value` (no spaces around `=`)
- Command substitution: `` `command` `` or `$(command)`
- String interpolation: `"$VAR"` or `"${VAR}"`
- Arrays: `set -A ARRAY item1 item2 item3`
- Arithmetic expansion: `$((expression))`
- Pattern matching: `[[ string =~ pattern ]]` (Korn shell style)
- Uses `print` command (Korn shell style) instead of `echo`

## Fragment Authoring
Write valid mksh shell commands. Your fragment becomes the script body. The fragment code will execute as part of the shell script.

Fragments are injected at the point where `print "Hello World!"` appears, so you can replace the print statement or add additional commands.

## Available Commands
Standard Unix utilities and mksh built-ins are available:
- `print` - Print text (Korn shell style)
- `echo` - Print text (POSIX style, also available)
- `printf` - Formatted output
- `test` / `[` / `[[` - Conditional tests
- `if`, `while`, `for`, `until` - Control structures
- `grep`, `sed`, `awk` - Text processing
- Standard Unix utilities

## Common Patterns
- Output: `print "message"` or `echo "message"` or `printf "%s\n" "message"`
- Variables: `NAME="value"` and `print "$NAME"`
- Arrays: `set -A ARRAY item1 item2 item3` and `print "${ARRAY[@]}"`
- Conditionals: `if [[ condition ]]; then ... fi`
- Loops: `for i in 1 2 3 4 5; do print "$i"; done` or `for i in $(seq 1 5); do print "$i"; done`
- Command substitution: `RESULT=$(command)`
- Arithmetic: `$((A + B))` or `let "result = A + B"`
- Functions: `function_name() { ... }`
- Here documents: `cat <<EOF ... EOF`

## Examples
```mksh
# Simple output
print "Hello from fragment!"

# Variables
NAME="Alice"
print "Hello, $NAME!"

# Arithmetic
A=5
B=10
SUM=$((A + B))
print "Sum: $SUM"

# Arrays
set -A FRUITS apple banana cherry
for fruit in "${FRUITS[@]}"; do
    print "Fruit: $fruit"
done

# Conditionals
if [[ "test" == "test" ]]; then
    print "Testing mode"
else
    print "Normal mode"
fi

# Functions
greet() {
    local name="$1"
    print "Hello, $name!"
}

greet "World"

# Command substitution
DATE=$(date)
print "Current date: $DATE"

# Arithmetic loops (using seq)
for i in $(seq 1 5); do
    print "Count: $i"
done

# Multiple statements
print "First line"
print "Second line"
print "Third line"

# Nested conditionals
if [[ -n "$1" ]]; then
    if [[ "$1" == "hello" ]]; then
        print "Greeting received"
    else
        print "Other argument: $1"
    fi
else
    print "No argument provided"
fi
```

## Caveats
- Variable assignment: no spaces around `=`
- Use `[[` for Korn shell-specific tests, `[` for POSIX compatibility
- Quote variables to prevent word splitting: `"$VAR"`
- Arrays use `set -A` syntax: `set -A ARRAY item1 item2 item3`
- Array access: `"${ARRAY[@]}"` for all elements, `"${ARRAY[0]}"` for first element
- Case-sensitive variable names
- Arithmetic expansion: `$((expression))` (no `$` inside)
- Function definitions: `function_name() { ... }` or `function function_name { ... }`
- Use `local` keyword inside functions to avoid global variable pollution
- Prefer `print` over `echo` for Korn shell style (though `echo` also works)
- Brace expansion like `{1..5}` does NOT work in mksh (use explicit lists or `seq`)

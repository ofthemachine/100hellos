# zsh Fraglet Guide

## Language Version
zsh (Z Shell) - Advanced shell with many interactive features

## Execution Model
- Interpreted shell script
- Code executes directly from source
- Scripts run line-by-line from top to bottom
- Compatible with bash but with enhanced features

## Key Characteristics
- Advanced shell with many extensions beyond POSIX
- Case-sensitive
- Variables: `VAR=value` (no spaces around `=`)
- Command substitution: `` `command` `` or `$(command)`
- String interpolation: `"$VAR"` or `"${VAR}"`
- Arrays: `ARRAY=(item1 item2 item3)` (indexed from 1, not 0)
- Associative arrays: `typeset -A MAP`
- Arithmetic expansion: `$((expression))`
- Pattern matching: `[[ string =~ pattern ]]`
- Extended globbing: `**/*.txt` (recursive), `*.txt~*.old` (exclusion)
- Parameter expansion: `${VAR:-default}`, `${VAR#pattern}`, etc.

## Fragment Authoring
Write valid zsh shell commands. Your fragment becomes the script body. The fragment code will execute as part of the shell script.

## Available Commands
Standard Unix utilities and zsh built-ins are available:
- `echo` - Print text
- `printf` - Formatted output
- `test` / `[` / `[[` - Conditional tests
- `if`, `while`, `for`, `until` - Control structures
- `grep`, `sed`, `awk` - Text processing
- `jq` - JSON processing (if installed)
- Standard Unix utilities

## Common Patterns
- Output: `echo "message"` or `printf "%s\n" "message"`
- Variables: `NAME="value"` and `echo "$NAME"`
- Arrays: `ARRAY=(1 2 3)` and `echo "${ARRAY[@]}"` (indexed from 1)
- Conditionals: `if [[ condition ]]; then ... fi`
- Loops: `for i in {1..5}; do echo "$i"; done` or `for i in {1..5}; echo "$i"`
- Command substitution: `RESULT=$(command)`
- Arithmetic: `$((A + B))` or `let "result = A + B"`
- Functions: `function_name() { ... }`
- Here documents: `cat <<EOF ... EOF`
- Parameter expansion: `${VAR:-default}`, `${VAR#prefix}`, `${VAR%suffix}`

## Examples
```zsh
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

# Arrays (indexed from 1)
FRUITS=("apple" "banana" "cherry")
for fruit in "${FRUITS[@]}"; do
    echo "Fruit: $fruit"
done
echo "First fruit: ${FRUITS[1]}"

# Conditionals
if [[ "$1" == "test" ]]; then
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

# Arithmetic loops
for i in {1..5}; do
    echo "Count: $i"
done

# Associative arrays
typeset -A colors
colors[red]="#FF0000"
colors[green]="#00FF00"
echo "Red: ${colors[red]}"

# Parameter expansion
VAR=""
echo "Value: ${VAR:-default}"

# Extended globbing (if enabled)
# files=(**/*.txt)  # recursive glob
# echo "Found ${#files[@]} files"

# String manipulation
TEXT="Hello World"
echo "${TEXT#Hello }"  # Remove prefix
echo "${TEXT% World}"  # Remove suffix
```

## Caveats
- Variable assignment: no spaces around `=`
- Use `[[` for zsh-specific tests, `[` for POSIX compatibility
- Quote variables to prevent word splitting: `"$VAR"`
- Arrays are indexed from 1, not 0: `${ARRAY[1]}` is the first element
- Arrays require proper quoting: `"${ARRAY[@]}"` for all elements
- Case-sensitive variable names
- Arithmetic expansion: `$((expression))` (no `$` inside)
- Function definitions: `function_name() { ... }` or `function function_name { ... }`
- Use `local` keyword inside functions to avoid global variable pollution
- Associative arrays use `typeset -A` declaration
- Extended globbing may need `setopt extendedglob` (usually enabled by default in scripts)

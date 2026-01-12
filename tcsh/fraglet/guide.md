# tcsh Fraglet Guide

## Language Version
tcsh (TENEX C Shell) - Enhanced C shell with command-line editing and completion

## Execution Model
- Interpreted shell script
- Code executes directly from source
- Scripts run line-by-line from top to bottom

## Key Characteristics
- C shell variant with enhancements
- Case-sensitive
- Variables: `set VAR=value` (use `set` keyword)
- Command substitution: `` `command` `` or `$(command)`
- String interpolation: `"$VAR"` or `"${VAR}"`
- Arrays: `set ARRAY=(item1 item2 item3)`
- Arithmetic: `@ VAR = expression` (use `@` for arithmetic)
- Pattern matching: `=~` operator in conditionals
- C-like syntax for conditionals: `if (condition) then ... endif`

## Fragment Authoring
Write valid tcsh shell commands. Your fragment becomes the script body. The fragment code will execute as part of the shell script.

## Available Commands
Standard Unix utilities and tcsh built-ins are available:
- `echo` - Print text
- `printf` - Formatted output
- `test` - Conditional tests
- `if`, `while`, `foreach`, `switch` - Control structures
- `grep`, `sed`, `awk` - Text processing
- Standard Unix utilities

## Common Patterns
- Output: `echo "message"` or `printf "%s\n" "message"`
- Variables: `set NAME="value"` and `echo "$NAME"`
- Arrays: `set ARRAY=(1 2 3)` and `echo "$ARRAY[1]"`
- Conditionals: `if (condition) then ... endif`
- Loops: `foreach i (1 2 3 4 5); echo "$i"; end`
- Command substitution: `set RESULT=\`command\``
- Arithmetic: `@ VAR = expression` (use `@` for arithmetic operations)
- Functions: `alias function_name 'commands'`

## Examples
```tcsh
# Simple output
echo "Hello from fragment!"

# Variables
set NAME="Alice"
echo "Hello, $NAME!"

# Arithmetic
@ A = 5
@ B = 10
@ SUM = $A + $B
echo "Sum: $SUM"

# Arrays
set FRUITS=(apple banana cherry)
foreach fruit ($FRUITS)
    echo "Fruit: $fruit"
end

# Conditionals
if ("test" == "test") then
    echo "Testing mode"
else
    echo "Normal mode"
endif

# While loops
@ i = 1
while ($i <= 5)
    echo "Count: $i"
    @ i++
end

# Command substitution
set DATE=`date`
echo "Current date: $DATE"

# Array indexing
set ARRAY=(one two three)
echo "First: $ARRAY[1]"
echo "All: $ARRAY"

# String operations
set STR="Hello World"
echo "Length: $#STR"
echo "First word: $STR[1]"
```

## Caveats
- Variable assignment: use `set VAR=value` (not `VAR=value` like bash)
- Arithmetic: use `@ VAR = expression` (not `$((expression))`)
- Conditionals: use `if (condition) then ... endif` (C-like syntax)
- Arrays: use `set ARRAY=(items)` and access with `$ARRAY[index]` (1-indexed)
- Loops: use `foreach` or `while` with `end` (not `done` like bash)
- Command substitution: use backticks `` `command` `` or `$(command)`
- String length: use `$#VAR` (not `${#VAR}`)
- Case-sensitive variable names
- Use `@` for arithmetic operations, not `$((...))`
- Array indexing starts at 1, not 0

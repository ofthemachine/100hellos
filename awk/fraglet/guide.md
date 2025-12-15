# AWK Fraglet Guide

## Language Version
GNU AWK (gawk)

## Execution Model
- Interpreted, runs directly from source
- Code executes in blocks: BEGIN, pattern-action, END
- Scripts use `.awk` extension or can be executed with `awk -f script.awk`

## Key Characteristics
- Pattern-action programming language
- Field-based text processing
- Built-in variables: `$0` (entire line), `$1`, `$2`, etc. (fields)
- Automatic field splitting on whitespace
- Case-sensitive
- Indentation is preserved based on the injection point

## Fragment Authoring
Write normal AWK code: define any functions first, then put runtime logic in `BEGIN { ... }`. Your fraglet becomes the script body; you don’t need to know how it’s wired into the container.

## Available Packages
Standard AWK (gawk) is available. No additional packages are pre-installed.

## Common Patterns
- Print: `print "message"` or `print("message")`
- String concatenation: `"Hello" " " "World"` or `"Hello" " " name`
- Variables: `name = "Alice"` (no declaration needed)
- Arrays: `arr[1] = "value"` (associative arrays)
- Loops: `for (i in array) { }` or `for (i = 1; i <= 10; i++) { }`
- Conditionals: `if (condition) { } else { }`
- Functions: `function name(args) { }` (must be defined outside BEGIN block, but can be included in fraglet)

## Examples
```awk
# Simple output
BEGIN {
  print "Hello, World!"
}

# Variable assignment
BEGIN {
  name = "Alice"
  print "Hello, " name "!"
}

# Array processing
BEGIN {
  numbers[1] = 1
  numbers[2] = 2
  numbers[3] = 3
  numbers[4] = 4
  numbers[5] = 5

  sum = 0
  for (i in numbers) {
      sum += numbers[i] * numbers[i]
  }
  print "Sum of squares: " sum
}

# Function definition (outside BEGIN block) with execution (inside BEGIN block)
function greet(name) {
    return "Hello, " name "!"
}

BEGIN {
    print greet("Bob")
}
```

## Caveats
- AWK is primarily designed for text processing with input streams
- For fraglets without input, use BEGIN blocks (already in the file)
- String concatenation is done by placing strings next to each other
- Arrays are associative (can use strings as indices)
- Variables don't need declaration
- Field variables (`$1`, `$2`, etc.) are only meaningful when processing input


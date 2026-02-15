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

## Fragment Authoring
Write normal AWK code: define any functions first, then put runtime logic in `BEGIN { ... }`. Your fragment becomes the script body; you don’t need to know how it’s wired into the container.

## Available Packages
Standard AWK (gawk) is available. No additional packages are pre-installed.

## Command-line arguments
Arguments passed to your script are available in AWK as `ARGC` (count) and `ARGV` (with `ARGV[0]` as the program name; your arguments in `ARGV[1]`, `ARGV[2]`, …). Use them in a `BEGIN` block and then set `ARGC = 1` so AWK does not try to open those strings as input files:

```awk
BEGIN {
  for (i = 1; i < ARGC; i++)
    print ARGV[i]
  ARGC = 1
}
```

## Stdin
When there are no input files (or after you set `ARGC = 1`), AWK reads from stdin. Use a pattern–action rule to process each line. To echo lines use `{ print }` or `{ print $0 }`. For uppercase output (gawk), use `toupper()`:

```awk
{ print toupper($0) }
```

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
- For fraglets without input, use `BEGIN` blocks (already in the file)
- When using `ARGV` for arguments, set `ARGC = 1` in `BEGIN` so extra args are not treated as input files
- String concatenation is done by placing strings next to each other
- Arrays are associative (can use strings as indices)
- Variables don't need declaration
- Field variables (`$0`, `$1`, `$2`, etc.) are only meaningful when processing input lines


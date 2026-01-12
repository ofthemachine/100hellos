# Tcl Fraglet Guide

## Language Version
Tcl 8.6.x

## Execution Model
- Interpreted, runs directly from source via `tclsh`
- Top-level code executes immediately
- No explicit main function required
- Commands are executed in order from top to bottom

## Key Characteristics
- Everything is a string (with automatic type conversion)
- Dynamic typing
- Case-sensitive
- Command-based syntax: `command arg1 arg2`
- Variables: `set var value`
- Braces `{}` for literal strings, quotes `""` for substitution
- Square brackets `[]` for command substitution

## Fragment Authoring
Write valid Tcl statements or expressions. Your fragment becomes the script body. Code executes at the top level, so commands run immediately in order. You can define procedures (procs) and use them in the same fragment.

## Available Packages
Standard Tcl library is available. No additional packages are pre-installed.

## Common Patterns
- Print: `puts "message"` or `puts {message}`
- Variables: `set name "value"`
- Command substitution: `set result [expr 2 + 2]`
- Procedures: `proc name {args} { body }`
- Lists: `set items {a b c}` or `list a b c`
- Loops: `for {set i 0} {$i < 10} {incr i} { puts $i }`
- Conditionals: `if {condition} { body }`
- String operations: `string length $str`, `string toupper $str`

## Examples
```tcl
# Simple output
puts "Hello, World!"

# Variables and expressions
set a 5
set b 10
set sum [expr $a + $b]
puts "Sum: $sum"

# Procedure definition
proc greet {name} {
    return "Hello, $name!"
}

puts [greet "Alice"]

# List processing
set numbers {1 2 3 4 5}
set total 0
foreach num $numbers {
    set total [expr $total + $num]
}
puts "Total: $total"

# String manipulation
set text "hello world"
set upper [string toupper $text]
puts "Uppercase: $upper"

# Conditional logic
set score 85
if {$score >= 90} {
    puts "Grade: A"
} elseif {$score >= 80} {
    puts "Grade: B"
} else {
    puts "Grade: C"
}
```

## Caveats
- Braces `{}` prevent variable substitution, quotes `""` allow it
- Square brackets `[]` execute commands immediately (command substitution)
- Variables must be prefixed with `$` when reading, but not when setting
- Expressions require `expr` command: `expr 2 + 2` not `2 + 2`
- Indentation is not significant (unlike Python), but good style is recommended

# Raku Fraglet Guide

## Language Version
Raku (Rakudo)

## Execution Model
- Interpreted, runs directly from source
- Code executes at the top level
- Script runs once and exits
- Shebang support: `#!/usr/bin/env raku`

## Key Characteristics
- Dynamic typing with optional type annotations
- Case-sensitive
- Variables use sigils: `$` (scalar), `@` (array), `%` (hash), `&` (code)
- Object-oriented with classes, roles, and grammars
- Multiple dispatch (multi methods)
- Built-in regex engine (rules/grammars)
- Gradual typing (can add type constraints)
- Automatic memory management

## Fragment Authoring
Write valid Raku statements. Your fragment becomes the script body. Code runs at the top level of the script, so statements execute immediately. You can define classes, subroutines, use variables, and call functions.

## Available Packages
Standard Raku library is available. The container includes `zef` (Rakudo package manager) for installing additional modules if needed. Core modules include:
- Standard library functions and types
- Regex and grammar support
- Concurrency primitives (promises, channels, supplies)
- File I/O operations
- JSON support (if installed)

## Common Patterns
- Output: `say "message";` or `put "message";`
- Variables: `my $name = "Alice";`
- Arrays: `my @list = 1, 2, 3;`
- Hashes: `my %hash = key => "value";`
- Subroutines: `sub greet($name) { return "Hello, $name!"; }`
- Classes: `class Person { has Str $.name; }`
- Conditionals: `if $condition { ... } else { ... }`
- Loops: `for @list -> $item { ... }`
- String interpolation: `"Hello, $name!"`
- Method calls: `$object.method();`

## Examples
```raku
# Simple output
say "Hello, World!";

# Variables and string interpolation
my $name = "Alice";
say "Hello, $name!";

# Arrays and list processing
my @numbers = 1, 2, 3, 4, 5;
my $sum = [+] @numbers.map(* ** 2);
say "Sum of squares: $sum";

# Subroutines
sub greet(Str $name --> Str) {
    return "Hello, $name!";
}

say greet("World");

# Hashes
my %colors = (
    red => "#FF0000",
    green => "#00FF00",
    blue => "#0000FF"
);
say "Red: %colors<red>";

# Classes
class Person {
    has Str $.name;
    has Int $.age;
    
    method introduce() {
        say "I'm $.name, $.age years old";
    }
}

my $person = Person.new(name => "Alice", age => 30);
$person.introduce();

# Regular expressions
my $text = "Hello World";
$text ~~ s/World/Raku/;
say $text;

# List processing with map and reduce
my @squared = (1..5).map(* ** 2);
say "Squares: @squared.join(', ')";
```

## Caveats
- Always use `my` to declare variables (lexical scope)
- String interpolation only works in double quotes, not single quotes
- Array and hash access use different syntax: `@array[0]` vs `%hash<key>` or `%hash{'key'}`
- Method calls use `.` (dot) operator
- Type constraints are optional but can be added: `sub add(Int $a, Int $b --> Int) { ... }`
- `say` adds a newline, `print` does not
- Raku uses `~~` for smart matching, not `=~` like Perl
- Junction operators (`|`, `&`, `^`) provide powerful logic operations

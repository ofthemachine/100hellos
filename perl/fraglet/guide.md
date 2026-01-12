# Perl Fraglet Guide

## Language Version
Perl 5.x

## Execution Model
- Interpreted, runs directly from source
- Code executes at the top level
- Script runs once and exits

## Key Characteristics
- Dynamic typing
- Case-sensitive
- Variables use sigils: `$` (scalar), `@` (array), `%` (hash)
- Context-sensitive (scalar vs list context)
- Automatic memory management
- Regular expressions are first-class

## Fragment Authoring
Write valid Perl statements. Your fragment becomes the script body. Code runs at the top level of the script, so statements execute immediately. You can define subroutines, use variables, and call functions.

## Available Packages
Standard Perl library is available. Core modules include:
- `strict` and `warnings` (recommended for production code)
- `Data::Dumper` - data structure debugging
- `File::Find` - file system traversal
- `Getopt::Long` - command-line option parsing
- `JSON` - JSON encoding/decoding (if installed)
- Many more in the standard library

## Common Patterns
- Print: `print "message\n";`
- Variables: `my $name = "Alice";`
- Arrays: `my @list = (1, 2, 3);`
- Hashes: `my %hash = (key => "value");`
- Subroutines: `sub greet { my ($name) = @_; return "Hello, $name!"; }`
- Conditionals: `if ($condition) { ... } else { ... }`
- Loops: `for my $item (@list) { ... }`
- Regular expressions: `$str =~ s/pattern/replacement/;`

## Examples
```perl
# Simple output
print "Hello, World!\n";

# Variables and string interpolation
my $name = "Alice";
print "Hello, $name!\n";

# Arrays
my @numbers = (1, 2, 3, 4, 5);
my $sum = 0;
for my $num (@numbers) {
    $sum += $num * $num;
}
print "Sum of squares: $sum\n";

# Functions
sub greet {
    my ($name) = @_;
    return "Hello, $name!";
}

print greet("World") . "\n";

# Hashes
my %colors = (
    red => "#FF0000",
    green => "#00FF00",
    blue => "#0000FF"
);
print "Red: $colors{red}\n";

# Regular expressions
my $text = "Hello World";
$text =~ s/World/Perl/;
print "$text\n";

# List processing with map
my @squared = map { $_ * $_ } (1..5);
print "Squares: @squared\n";
```

## Caveats
- Always use `my` to declare variables (avoids global scope pollution)
- Remember to add newlines (`\n`) to print statements for proper output
- String interpolation only works in double quotes, not single quotes
- Array and hash access use different syntax: `$array[0]` vs `$hash{key}`
- Context matters: `@array` in scalar context returns length, not the array itself

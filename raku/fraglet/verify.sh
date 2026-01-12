#!/bin/bash
# verify.sh - Smoke tests for raku fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/raku:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello, World!" <<'EOF'
say "Hello, World!";
EOF

# Example 2: Variables and string interpolation
verify_fraglet "Hello, Alice" <<'EOF'
my $name = "Alice";
say "Hello, $name!";
EOF

# Example 3: Arrays and list processing
verify_fraglet "Sum of squares:" <<'EOF'
my @numbers = 1, 2, 3, 4, 5;
my $sum = [+] @numbers.map(* ** 2);
say "Sum of squares: $sum";
EOF

# Example 4: Subroutines
verify_fraglet "Hello, World!" <<'EOF'
sub greet(Str $name --> Str) {
    return "Hello, $name!";
}

say greet("World");
EOF

# Example 6: Hashes
verify_fraglet "Red: #FF0000" <<'EOF'
my %colors = (
    red => "#FF0000",
    green => "#00FF00",
    blue => "#0000FF"
);
say "Red: %colors<red>";
EOF

# Example 6: Classes
verify_fraglet "I'm Alice" <<'EOF'
class Person {
    has Str $.name;
    has Int $.age;
    
    method introduce() {
        say "I'm $.name, $.age years old";
    }
}

my $person = Person.new(name => "Alice", age => 30);
$person.introduce();
EOF

# Example 8: Regular expressions
verify_fraglet "Hello Raku" <<'EOF'
my $text = "Hello World";
$text ~~ s/World/Raku/;
say $text;
EOF

# Example 8: List processing with map and reduce
verify_fraglet "Squares:" <<'EOF'
my @squared = (1..5).map(* ** 2);
say "Squares: @squared.join(', ')";
EOF

echo "✓ All tests passed"

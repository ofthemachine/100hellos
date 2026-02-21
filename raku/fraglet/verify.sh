#!/bin/bash
# verify.sh - Smoke tests for raku fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/raku:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.raku"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
say "Hello, World!";
EOF
verify_fraglet "Hello, World!"

cat > "$tmp" <<'EOF'
my $name = "Alice";
say "Hello, $name!";
EOF
verify_fraglet "Hello, Alice"

cat > "$tmp" <<'EOF'
my @numbers = 1, 2, 3, 4, 5;
my $sum = [+] @numbers.map(* ** 2);
say "Sum of squares: $sum";
EOF
verify_fraglet "Sum of squares:"

cat > "$tmp" <<'EOF'
sub greet(Str $name --> Str) {
    return "Hello, $name!";
}

say greet("World");
EOF
verify_fraglet "Hello, World!"

cat > "$tmp" <<'EOF'
my %colors = (
    red => "#FF0000",
    green => "#00FF00",
    blue => "#0000FF"
);
say "Red: %colors<red>";
EOF
verify_fraglet "Red: #FF0000"

cat > "$tmp" <<'EOF'
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
verify_fraglet "I'm Alice"

cat > "$tmp" <<'EOF'
my $text = "Hello World";
$text ~~ s/World/Raku/;
say $text;
EOF
verify_fraglet "Hello Raku"

cat > "$tmp" <<'EOF'
my @squared = (1..5).map(* ** 2);
say "Squares: @squared.join(', ')";
EOF
verify_fraglet "Squares:"

echo "✓ All tests passed"

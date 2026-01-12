#!/bin/bash
# verify.sh - Smoke tests for perl fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/perl:local}"

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
print "Hello, World!\n";
EOF

# Example 2: Variables and string interpolation
verify_fraglet "Hello, Alice" <<'EOF'
my $name = "Alice";
print "Hello, $name!\n";
EOF

# Example 3: Arrays
verify_fraglet "Sum of squares: 55" <<'EOF'
my @numbers = (1, 2, 3, 4, 5);
my $sum = 0;
for my $num (@numbers) {
    $sum += $num * $num;
}
print "Sum of squares: $sum\n";
EOF

# Example 4: Functions
verify_fraglet "Hello, World!" <<'EOF'
sub greet {
    my ($name) = @_;
    return "Hello, $name!";
}

print greet("World") . "\n";
EOF

# Example 5: Hashes
verify_fraglet "Red: #FF0000" <<'EOF'
my %colors = (
    red => "#FF0000",
    green => "#00FF00",
    blue => "#0000FF"
);
print "Red: $colors{red}\n";
EOF

# Example 6: Regular expressions
verify_fraglet "Hello Perl" <<'EOF'
my $text = "Hello World";
$text =~ s/World/Perl/;
print "$text\n";
EOF

# Example 7: List processing with map
verify_fraglet "Squares:" <<'EOF'
my @squared = map { $_ * $_ } (1..5);
print "Squares: @squared\n";
EOF

echo "✓ All tests passed"

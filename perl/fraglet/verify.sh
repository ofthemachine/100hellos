#!/bin/bash
# verify.sh - Smoke tests for Perl fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/perl:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.pl"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
print "Hello, World!\n";
EOF
verify_fraglet "Hello, World!"

cat > "$tmp" <<'EOF'
my $name = "Alice";
print "Hello, $name!\n";
EOF
verify_fraglet "Hello, Alice"

cat > "$tmp" <<'EOF'
my @numbers = (1, 2, 3, 4, 5);
my $sum = 0;
for my $num (@numbers) {
    $sum += $num * $num;
}
print "Sum of squares: $sum\n";
EOF
verify_fraglet "Sum of squares: 55"

cat > "$tmp" <<'EOF'
sub greet {
    my ($name) = @_;
    return "Hello, $name!";
}

print greet("World") . "\n";
EOF
verify_fraglet "Hello, World!"

cat > "$tmp" <<'EOF'
my %colors = (
    red => "#FF0000",
    green => "#00FF00",
    blue => "#0000FF"
);
print "Red: $colors{red}\n";
EOF
verify_fraglet "Red: #FF0000"

cat > "$tmp" <<'EOF'
my $text = "Hello World";
$text =~ s/World/Perl/;
print "$text\n";
EOF
verify_fraglet "Hello Perl"

cat > "$tmp" <<'EOF'
my @squared = map { $_ * $_ } (1..5);
print "Squares: @squared\n";
EOF
verify_fraglet "Squares:"

echo "✓ All tests passed"

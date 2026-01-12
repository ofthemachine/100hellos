#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/verilog:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello from fragment!" <<'EOF'
initial begin
    $display("Hello from fragment!");
    $finish;
end
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
integer a, b, sum;
initial begin
    a = 5;
    b = 10;
    sum = a + b;
    $display("Sum: %d", sum);
    $finish;
end
EOF

# Example 3: Loops
verify_fraglet "Count:" <<'EOF'
integer i;
initial begin
    for (i = 1; i <= 5; i = i + 1) begin
        $display("Count: %d", i);
    end
    $finish;
end
EOF

# Example 4: Arrays and iteration
verify_fraglet "numbers\[" <<'EOF'
integer numbers[0:4];
integer i;
initial begin
    for (i = 0; i < 5; i = i + 1) begin
        numbers[i] = i * 2;
        $display("numbers[%d] = %d", i, numbers[i]);
    end
    $finish;
end
EOF

# Example 5: Conditionals
verify_fraglet "Value is" <<'EOF'
integer value;
initial begin
    value = 42;
    if (value > 50) begin
        $display("Value is greater than 50");
    end else begin
        $display("Value is %d", value);
    end
    $finish;
end
EOF

echo "✓ All tests passed"

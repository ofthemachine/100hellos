#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/csharp:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output (top-level statements)
verify_fraglet "Hello from fragment!" <<'EOF'
Console.WriteLine("Hello from fragment!");
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
int a = 5;
int b = 10;
Console.WriteLine($"Sum: {a + b}");
EOF

# Example 3: Using List collection
verify_fraglet "List sum: 15" <<'EOF'
var numbers = new List<int> { 1, 2, 3, 4, 5 };
int sum = 0;
foreach (int num in numbers) {
    sum += num;
}
Console.WriteLine($"List sum: {sum}");
EOF

# Example 4: String operations
verify_fraglet "Hello World!" <<'EOF'
string message = "Hello";
message += " World!";
Console.WriteLine(message);
EOF

# Example 5: Simple class (using Main method)
verify_fraglet "5 + 3 = 8" <<'EOF'
public class Calculator {
    public int Add(int a, int b) {
        return a + b;
    }
}

public class Program {
    public static void Main() {
        var calc = new Calculator();
        Console.WriteLine($"5 + 3 = {calc.Add(5, 3)}");
    }
}
EOF

# Example 6: Generic method (using Main method)
verify_fraglet "Max(5, 10) = 10" <<'EOF'
public class Program {
    public static T Maximum<T>(T a, T b) where T : IComparable<T> {
        return a.CompareTo(b) > 0 ? a : b;
    }
    
    public static void Main() {
        Console.WriteLine($"Max(5, 10) = {Maximum(5, 10)}");
        Console.WriteLine($"Max(3.14, 2.71) = {Maximum(3.14, 2.71)}");
    }
}
EOF

# Example 7: LINQ example
verify_fraglet "Even numbers:" <<'EOF'
var numbers = new[] { 1, 2, 3, 4, 5 };
var evens = numbers.Where(n => n % 2 == 0);
Console.WriteLine($"Even numbers: {string.Join(", ", evens)}");
EOF

echo "✓ All tests passed"

#!/bin/bash
# verify.sh - Smoke tests for vala fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/vala:local}"

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
void main() {
    print("Hello from fragment!\n");
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
void main() {
    int a = 5;
    int b = 10;
    print("Sum: %d\n", a + b);
}
EOF

# Example 3: Functions
verify_fraglet "5 + 10 = 15" <<'EOF'
int add(int a, int b) {
    return a + b;
}

void main() {
    int result = add(5, 10);
    print("5 + 10 = %d\n", result);
}
EOF

# Example 4: Classes and properties
verify_fraglet "5 + 3 = 8" <<'EOF'
class Calculator {
    public int add(int a, int b) {
        return a + b;
    }
}

void main() {
    var calc = new Calculator();
    print("5 + 3 = %d\n", calc.add(5, 3));
}
EOF

# Example 5: Properties
verify_fraglet "Alice is 30 years old" <<'EOF'
class Person {
    public string name { get; set; }
    public int age { get; set; }

    public Person(string name, int age) {
        this.name = name;
        this.age = age;
    }
}

void main() {
    var person = new Person("Alice", 30);
    print("%s is %d years old\n", person.name, person.age);
}
EOF

# Example 6: Signals
verify_fraglet "Hello, World!" <<'EOF'
class Greeter : Object {
    public signal void greeted(string who);

    public void greet(string name) {
        greeted(name);
    }
}

void main() {
    var greeter = new Greeter();
    greeter.greeted.connect((who) => {
        print("Hello, %s!\n", who);
    });
    greeter.greet("World");
}
EOF

# Example 7: String operations
verify_fraglet "Hello World!" <<'EOF'
void main() {
    string s = "Hello";
    s += " World!";
    print("%s\n", s);
}
EOF

# Example 8: Arrays
verify_fraglet "Sum: 15" <<'EOF'
void main() {
    int[] numbers = {1, 2, 3, 4, 5};
    int sum = 0;
    foreach (int num in numbers) {
        sum += num;
    }
    print("Sum: %d\n", sum);
}
EOF

# Example 9: Closures and delegates
verify_fraglet "Value: 42" <<'EOF'
delegate void Callback(int x);

void main() {
    Callback cb = (x) => {
        print("Value: %d\n", x);
    };

    cb(42);
}
EOF

echo "✓ All tests passed"

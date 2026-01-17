#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/java:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    local code=$(cat)
    local output
    output=$(echo "$code" | fragletc --image "$IMAGE" - 2>&1)
    echo "$output" | grep -q "$expected" || {
        echo "Failed: Expected '$expected' not found in output"
        return 1
    }
}

# Helper: verify fraglet with mode
verify_fraglet_mode() {
    local mode="$1"
    local expected="$2"
    local code=$(cat)
    local output
    output=$(echo "$code" | fragletc --image "$IMAGE" --mode "$mode" - 2>&1)
    echo "$output" | grep -q "$expected" || {
        echo "Failed: Expected '$expected' not found in output for mode '$mode'"
        return 1
    }
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing default mode (general Java)..."

# Example 1: Simple output
verify_fraglet "Hello from fragment!" <<'EOF'
public static void main(String[] args) throws Exception {
    System.out.println("Hello from fragment!");
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
public static void main(String[] args) throws Exception {
    int a = 5;
    int b = 10;
    int sum = a + b;
    System.out.println("Sum: " + sum);
}
EOF

# Example 3: Arrays and loops
verify_fraglet "Array sum: 15" <<'EOF'
public static void main(String[] args) throws Exception {
    int[] numbers = {1, 2, 3, 4, 5};
    int sum = 0;
    for (int num : numbers) {
        sum += num;
    }
    System.out.println("Array sum: " + sum);
}
EOF

# Example 4: Method definition
verify_fraglet "5 + 10 = 15" <<'EOF'
public static int add(int a, int b) {
    return a + b;
}

public static void main(String[] args) throws Exception {
    int result = add(5, 10);
    System.out.println("5 + 10 = " + result);
}
EOF

# Example 5: Nested class definition
verify_fraglet "5 \* 3 = 15" <<'EOF'
public static void main(String[] args) throws Exception {
    class Calculator {
        public int multiply(int a, int b) {
            return a * b;
        }
    }
    
    Calculator calc = new Calculator();
    System.out.println("5 * 3 = " + calc.multiply(5, 3));
}
EOF

# Example 6: Command-line arguments
echo "Testing argument passing..."
fragletc --image "$IMAGE" - arg1 arg2 <<'EOF' 2>&1 | grep -q "First argument: arg1"
public static void main(String[] args) throws Exception {
    if (args.length > 0) {
        System.out.println("First argument: " + args[0]);
    }
}
EOF

echo "Testing wordalytica mode..."

# Wordalytica Example 1: Simple wordset usage
verify_fraglet_mode "wordalytica" "Count:" <<'EOF'
WordSet<?> words = HelloWorld.loadWords();
int n = words.endingWith("ing").count();
System.out.println("Count: " + n);
EOF

# Wordalytica Example 2: Word matching
verify_fraglet_mode "wordalytica" "hello" <<'EOF'
WordSet<?> words = HelloWorld.loadWords();
words.matching("hello").iterator().forEachRemaining(System.out::println);
EOF

# Wordalytica Example 3: Scrabble scoring
verify_fraglet_mode "wordalytica" "quartz" <<'EOF'
WordSet<?> words = HelloWorld.loadWords();
int score = HelloWorld.wordScore("quartz");
System.out.println("quartz = " + score);
EOF

echo "✓ All tests passed"

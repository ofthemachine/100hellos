#!/bin/bash
# verify.sh - Smoke tests for Java fraglet support (base + guide examples + wordalytica).
# Contract: default run, guide examples (full-file fraglets), wordalytica mode. Args in verify_args.sh.

set -euo pipefail

IMAGE="${1:-100hellos/java:local}"
EXT=".java"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -Fq "$expected"
}

verify_fraglet_mode() {
    local mode="$1"
    local expected="$2"
    shift 2
    fragletc --image "$IMAGE" --mode "$mode" "$tmp" "$@" 2>&1 | grep -Fq "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing default mode (general Java, full-file fraglets)..."

# Example 1: Simple output
cat > "$tmp" <<'EOF'
import java.util.*;

public class Fraglet {
    public static void main(String[] args) {
        System.out.println("Hello from fragment!");
    }
}
EOF
verify_fraglet "Hello from fragment!"

# Example 2: Variables and calculations
cat > "$tmp" <<'EOF'
import java.util.*;

public class Fraglet {
    public static void main(String[] args) {
        int a = 5;
        int b = 10;
        int sum = a + b;
        System.out.println("Sum: " + sum);
    }
}
EOF
verify_fraglet "Sum: 15"

# Example 3: Arrays and loops
cat > "$tmp" <<'EOF'
import java.util.*;

public class Fraglet {
    public static void main(String[] args) {
        int[] numbers = {1, 2, 3, 4, 5};
        int sum = 0;
        for (int num : numbers) {
            sum += num;
        }
        System.out.println("Array sum: " + sum);
    }
}
EOF
verify_fraglet "Array sum: 15"

# Example 4: Method definition
cat > "$tmp" <<'EOF'
import java.util.*;

public class Fraglet {
    public static int add(int a, int b) {
        return a + b;
    }
    public static void main(String[] args) {
        int result = add(5, 10);
        System.out.println("5 + 10 = " + result);
    }
}
EOF
verify_fraglet "5 + 10 = 15"

# Example 5: Nested class definition
cat > "$tmp" <<'EOF'
import java.util.*;

public class Fraglet {
    public static void main(String[] args) {
        class Calculator {
            public int multiply(int a, int b) {
                return a * b;
            }
        }
        Calculator calc = new Calculator();
        System.out.println("5 * 3 = " + calc.multiply(5, 3));
    }
}
EOF
verify_fraglet "5 * 3 = 15"

echo "Testing wordalytica mode..."

# Wordalytica Example 1: Simple wordset usage
cat > "$tmp" <<'EOF'
WordSet<?> words = Wordalytica.loadWords();
int n = words.endingWith("ing").count();
System.out.println("Count: " + n);
EOF
verify_fraglet_mode "wordalytica" "Count:"

# Wordalytica Example 2: Word matching
cat > "$tmp" <<'EOF'
WordSet<?> words = Wordalytica.loadWords();
words.matching("hello").iterator().forEachRemaining(System.out::println);
EOF
verify_fraglet_mode "wordalytica" "hello"

# Wordalytica Example 3: Scrabble scoring
cat > "$tmp" <<'EOF'
WordSet<?> words = Wordalytica.loadWords();
int score = Wordalytica.wordScore("quartz");
System.out.println("quartz = " + score);
EOF
verify_fraglet_mode "wordalytica" "quartz"

# Wordalytica Example 4: startingWith
cat > "$tmp" <<'EOF'
WordSet<?> words = Wordalytica.loadWords();
int n = words.startingWith("un").count();
System.out.println("un-prefix count: " + n);
EOF
verify_fraglet_mode "wordalytica" "un-prefix count:"

# Wordalytica Example 5: matching pattern (5 letters, a at 2, e at 4)
cat > "$tmp" <<'EOF'
WordSet<?> words = Wordalytica.loadWords();
int n = words.matching("_a_e_").count();
System.out.println("_a_e_ count: " + n);
EOF
verify_fraglet_mode "wordalytica" "_a_e_ count:"

# Wordalytica Example 6: containing + notContaining
cat > "$tmp" <<'EOF'
WordSet<?> words = Wordalytica.loadWords();
long c = words.matching("_____").containing("q").notContaining("aeiou").count();
System.out.println("q-no-vowel 5-letter count: " + c);
EOF
verify_fraglet_mode "wordalytica" "q-no-vowel 5-letter count:"

# Wordalytica Example 7: longerThan
cat > "$tmp" <<'EOF'
WordSet<?> words = Wordalytica.loadWords();
int n = words.longerThan(14).count();
System.out.println("long words: " + n);
EOF
verify_fraglet_mode "wordalytica" "long words:"

# Wordalytica Example 8: withCharAt (Wordle-style green) — count 5-letter words starting with s
cat > "$tmp" <<'EOF'
WordSet<?> words = Wordalytica.loadWords();
int n = words.matching("s____").withCharAt('s', 0).count();
System.out.println("s____ count: " + n);
EOF
verify_fraglet_mode "wordalytica" "s____ count:"

# Wordalytica Example 9: Chain endingWith + count
cat > "$tmp" <<'EOF'
WordSet<?> words = Wordalytica.loadWords();
int n = words.endingWith("tion").count();
System.out.println("tion count: " + n);
EOF
verify_fraglet_mode "wordalytica" "tion count:"

echo "✓ All tests passed"

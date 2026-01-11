#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/idris2:local}"

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
main : IO ()
main = putStrLn "Hello from fragment!"
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
main : IO ()
main = do
  let a = 5
      b = 10
  putStrLn $ "Sum: " ++ show (a + b)
EOF

# Example 3: Functions
verify_fraglet "5 + 10 = 15" <<'EOF'
add : Int -> Int -> Int
add x y = x + y

main : IO ()
main = putStrLn $ "5 + 10 = " ++ show (add 5 10)
EOF

# Example 4: Pattern matching
verify_fraglet "Factorial of 5: 120" <<'EOF'
factorial : Nat -> Nat
factorial Z = 1
factorial (S k) = (S k) * factorial k

main : IO ()
main = putStrLn $ "Factorial of 5: " ++ show (factorial 5)
EOF

# Example 5: Lists and higher-order functions
verify_fraglet "Sum:" <<'EOF'
main : IO ()
main = do
  let numbers = [1, 2, 3, 4, 5]
      sum = foldl (+) 0 numbers
  putStrLn $ "Sum: " ++ show sum
EOF

# Example 6: String operations
verify_fraglet "Hello World!" <<'EOF'
main : IO ()
main = do
  let s = "Hello"
      t = s ++ " World!"
  putStrLn t
  putStrLn $ "Length: " ++ show (length t)
EOF

# Example 7: Dependent types (Vect)
verify_fraglet "Vector:" <<'EOF'
import Data.Vect

main : IO ()
main = do
  let vec : Vect 3 Int = [1, 2, 3]
  putStrLn $ "Vector: " ++ show vec
  putStrLn $ "Length: " ++ show (length vec)
EOF

# Example 8: Type-level computation
verify_fraglet "5 + 10 = 15" <<'EOF'
main : IO ()
main = do
  let result : Nat = plus 5 10
  putStrLn $ "5 + 10 = " ++ show result
EOF

echo "✓ All tests passed"

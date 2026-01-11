#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/haskell:local}"

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
main = putStrLn "Hello from fragment!"
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
main = do
  let a = 5
      b = 10
  putStrLn $ "Sum: " ++ show (a + b)
EOF

# Example 3: Functions
verify_fraglet "5 + 10 = 15" <<'EOF'
add :: Int -> Int -> Int
add x y = x + y

main = putStrLn $ "5 + 10 = " ++ show (add 5 10)
EOF

# Example 4: Pattern matching
verify_fraglet "Factorial of 5: 120" <<'EOF'
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

main = putStrLn $ "Factorial of 5: " ++ show (factorial 5)
EOF

# Example 5: Lists and higher-order functions
verify_fraglet "Sum:" <<'EOF'
main = do
  let numbers = [1, 2, 3, 4, 5]
      sum = foldl (+) 0 numbers
  putStrLn $ "Sum: " ++ show sum
EOF

# Example 6: List comprehensions
verify_fraglet "First 10 squares:" <<'EOF'
main = do
  let squares = [x*x | x <- [1..10]]
  putStrLn $ "First 10 squares: " ++ show squares
EOF

# Example 7: String operations
verify_fraglet "Hello World!" <<'EOF'
main = do
  let s = "Hello"
      t = s ++ " World!"
  putStrLn t
  putStrLn $ "Length: " ++ show (length t)
EOF

# Example 8: Guards and where clauses
verify_fraglet "Absolute of -5: 5" <<'EOF'
absolute :: Int -> Int
absolute x | x >= 0 = x
           | otherwise = -x

main = putStrLn $ "Absolute of -5: " ++ show (absolute (-5))
EOF

echo "✓ All tests passed"

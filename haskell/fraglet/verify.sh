#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/haskell:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.hs"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
main = putStrLn "Hello from fragment!"
EOF
verify_fraglet "Hello from fragment!"

cat > "$tmp" <<'EOF'
main = do
  let a = 5
      b = 10
  putStrLn $ "Sum: " ++ show (a + b)
EOF
verify_fraglet "Sum:"

cat > "$tmp" <<'EOF'
add :: Int -> Int -> Int
add x y = x + y

main = putStrLn $ "5 + 10 = " ++ show (add 5 10)
EOF
verify_fraglet "5 + 10 = 15"

cat > "$tmp" <<'EOF'
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

main = putStrLn $ "Factorial of 5: " ++ show (factorial 5)
EOF
verify_fraglet "Factorial of 5: 120"

cat > "$tmp" <<'EOF'
main = do
  let numbers = [1, 2, 3, 4, 5]
      sum = foldl (+) 0 numbers
  putStrLn $ "Sum: " ++ show sum
EOF
verify_fraglet "Sum:"

cat > "$tmp" <<'EOF'
main = do
  let squares = [x*x | x <- [1..10]]
  putStrLn $ "First 10 squares: " ++ show squares
EOF
verify_fraglet "First 10 squares:"

cat > "$tmp" <<'EOF'
main = do
  let s = "Hello"
      t = s ++ " World!"
  putStrLn t
  putStrLn $ "Length: " ++ show (length t)
EOF
verify_fraglet "Hello World!"

cat > "$tmp" <<'EOF'
absolute :: Int -> Int
absolute x | x >= 0 = x
           | otherwise = -x

main = putStrLn $ "Absolute of -5: " ++ show (absolute (-5))
EOF
verify_fraglet "Absolute of -5: 5"

echo "✓ All tests passed"

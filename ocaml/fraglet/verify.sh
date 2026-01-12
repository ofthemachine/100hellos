#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/ocaml:local}"

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
let () = print_endline "Hello from fragment!"
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum:" <<'EOF'
let () =
  let a = 5 in
  let b = 10 in
  Printf.printf "Sum: %d\n" (a + b)
EOF

# Example 3: Functions
verify_fraglet "5 + 10 = 15" <<'EOF'
let add x y = x + y

let () = Printf.printf "5 + 10 = %d\n" (add 5 10)
EOF

# Example 4: Pattern matching
verify_fraglet "Factorial of 5: 120" <<'EOF'
let rec factorial = function
  | 0 -> 1
  | n -> n * factorial (n - 1)

let () = Printf.printf "Factorial of 5: %d\n" (factorial 5)
EOF

# Example 5: Lists and higher-order functions
verify_fraglet "Sum:" <<'EOF'
let () =
  let numbers = [1; 2; 3; 4; 5] in
  let sum = List.fold_left (+) 0 numbers in
  Printf.printf "Sum: %d\n" sum
EOF

# Example 6: List comprehensions using List.init
verify_fraglet "First 10 squares:" <<'EOF'
let () =
  let squares = List.init 10 (fun x -> (x + 1) * (x + 1)) in
  Printf.printf "First 10 squares: %s\n" 
    (String.concat "; " (List.map string_of_int squares))
EOF

# Example 7: String operations
verify_fraglet "Hello World!" <<'EOF'
let () =
  let s = "Hello" in
  let t = s ^ " World!" in
  print_endline t;
  Printf.printf "Length: %d\n" (String.length t)
EOF

# Example 8: Recursive functions with pattern matching
verify_fraglet "Fibonacci(10): 55" <<'EOF'
let rec fibonacci = function
  | 0 -> 0
  | 1 -> 1
  | n -> fibonacci (n - 1) + fibonacci (n - 2)

let () = Printf.printf "Fibonacci(10): %d\n" (fibonacci 10)
EOF

# Example 9: Mutable references
verify_fraglet "Counter: 2" <<'EOF'
let () =
  let counter = ref 0 in
  counter := !counter + 1;
  counter := !counter + 1;
  Printf.printf "Counter: %d\n" !counter
EOF

echo "✓ All tests passed"

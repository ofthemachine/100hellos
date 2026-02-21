#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/ocaml:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.ml"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
let () = print_endline "Hello from fragment!"
EOF
verify_fraglet "Hello from fragment!"

cat > "$tmp" <<'EOF'
let () =
  let a = 5 in
  let b = 10 in
  Printf.printf "Sum: %d\n" (a + b)
EOF
verify_fraglet "Sum:"

cat > "$tmp" <<'EOF'
let add x y = x + y

let () = Printf.printf "5 + 10 = %d\n" (add 5 10)
EOF
verify_fraglet "5 + 10 = 15"

cat > "$tmp" <<'EOF'
let rec factorial = function
  | 0 -> 1
  | n -> n * factorial (n - 1)

let () = Printf.printf "Factorial of 5: %d\n" (factorial 5)
EOF
verify_fraglet "Factorial of 5: 120"

cat > "$tmp" <<'EOF'
let () =
  let numbers = [1; 2; 3; 4; 5] in
  let sum = List.fold_left (+) 0 numbers in
  Printf.printf "Sum: %d\n" sum
EOF
verify_fraglet "Sum:"

cat > "$tmp" <<'EOF'
let () =
  let squares = List.init 10 (fun x -> (x + 1) * (x + 1)) in
  Printf.printf "First 10 squares: %s\n"
    (String.concat "; " (List.map string_of_int squares))
EOF
verify_fraglet "First 10 squares:"

cat > "$tmp" <<'EOF'
let () =
  let s = "Hello" in
  let t = s ^ " World!" in
  print_endline t;
  Printf.printf "Length: %d\n" (String.length t)
EOF
verify_fraglet "Hello World!"

cat > "$tmp" <<'EOF'
let rec fibonacci = function
  | 0 -> 0
  | 1 -> 1
  | n -> fibonacci (n - 1) + fibonacci (n - 2)

let () = Printf.printf "Fibonacci(10): %d\n" (fibonacci 10)
EOF
verify_fraglet "Fibonacci(10): 55"

cat > "$tmp" <<'EOF'
let () =
  let counter = ref 0 in
  counter := !counter + 1;
  counter := !counter + 1;
  Printf.printf "Counter: %d\n" !counter
EOF
verify_fraglet "Counter: 2"

echo "✓ All tests passed"

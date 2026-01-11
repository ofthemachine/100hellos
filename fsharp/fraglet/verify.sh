#!/bin/bash
set -euo pipefail

IMAGE="${1:-100hellos/fsharp:local}"

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
printfn "Hello from fragment!"
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
let a = 5
let b = 10
printfn "Sum: %d" (a + b)
EOF

# Example 3: Using List collection
verify_fraglet "List sum: 15" <<'EOF'
let numbers = [1; 2; 3; 4; 5]
let sum = List.sum numbers
printfn "List sum: %d" sum
EOF

# Example 4: String operations
verify_fraglet "Hello World!" <<'EOF'
let message = "Hello"
let fullMessage = message + " World!"
printfn "%s" fullMessage
EOF

# Example 5: Simple function
verify_fraglet "5 + 3 = 8" <<'EOF'
let add a b = a + b
printfn "5 + 3 = %d" (add 5 3)
EOF

# Example 6: Pattern matching
verify_fraglet "Describe 1: one" <<'EOF'
let describe x =
    match x with
    | 0 -> "zero"
    | 1 -> "one"
    | _ -> "other"
printfn "Describe 1: %s" (describe 1)
EOF

# Example 7: List operations with pipeline
verify_fraglet "Even numbers:" <<'EOF'
let numbers = [1..10]
let evens = numbers |> List.filter (fun x -> x % 2 = 0)
printfn "Even numbers: %A" evens
EOF

# Example 8: Discriminated union
verify_fraglet "Success: 42" <<'EOF'
type Result = Success of int | Error of string
let result = Success 42
match result with
| Success value -> printfn "Success: %d" value
| Error msg -> printfn "Error: %s" msg
EOF

# Example 9: Record type
verify_fraglet "Name: Alice" <<'EOF'
type Person = { Name: string; Age: int }
let person = { Name = "Alice"; Age = 30 }
printfn "Name: %s, Age: %d" person.Name person.Age
EOF

echo "✓ All tests passed"

#!/bin/bash
# verify.sh - Smoke tests for Visual Basic fraglet support (base + guide examples).

set -euo pipefail

IMAGE="${1:-100hellos/visual-basic:local}"
EXT=".vb"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.$EXT"

verify_fraglet() {
    local expected="$1"
    shift
    fragletc --image "$IMAGE" "$tmp" "$@" 2>&1 | grep -Fq "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -Fq "Hello World!"

echo "Testing fraglet examples from guide.md..."

cat > "$tmp" <<'EOF'
Module Fraglet
    Sub Main(args As String())
        Console.WriteLine("Hello from fragment!")
    End Sub
End Module
EOF
verify_fraglet "Hello from fragment!"

cat > "$tmp" <<'EOF'
Module Fraglet
    Sub Main(args As String())
        Dim a As Integer = 5
        Dim b As Integer = 10
        Console.WriteLine($"Sum: {a + b}")
    End Sub
End Module
EOF
verify_fraglet "Sum: 15"

cat > "$tmp" <<'EOF'
Module Fraglet
    Sub Main(args As String())
        Dim numbers As New List(Of Integer) From {1, 2, 3, 4, 5}
        Dim sum As Integer = 0
        For Each num In numbers
            sum += num
        Next
        Console.WriteLine($"List sum: {sum}")
    End Sub
End Module
EOF
verify_fraglet "List sum: 15"

cat > "$tmp" <<'EOF'
Module Fraglet
    Sub Main(args As String())
        Dim message As String = "Hello"
        message &= " World!"
        Console.WriteLine(message)
    End Sub
End Module
EOF
verify_fraglet "Hello World!"

cat > "$tmp" <<'EOF'
Module Fraglet
    Sub Main(args As String())
        Dim multiply As Func(Of Integer, Integer, Integer) = Function(a, b) a * b
        Console.WriteLine($"5 * 3 = {multiply(5, 3)}")
    End Sub
End Module
EOF
verify_fraglet "5 * 3 = 15"

echo "Testing stdin..."
bash "$(dirname "$0")/verify_stdin.sh" "$IMAGE"

echo "Testing args..."
bash "$(dirname "$0")/verify_args.sh" "$IMAGE"

echo "✓ All tests passed"

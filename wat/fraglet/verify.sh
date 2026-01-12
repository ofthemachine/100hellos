#!/bin/bash
# verify.sh - Smoke tests for wat fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/wat:local}"

# Helper: verify fraglet compiles and runs, output contains expected string
verify_fraglet() {
    local expected="$1"
    fragletc --image "$IMAGE" - 2>&1 | grep -q "$expected"
}

echo "Testing default execution..."
docker run --rm "$IMAGE" | grep -q "Hello World!"

echo "Testing fraglet examples from guide.md..."

# Example 1: Simple output
verify_fraglet "Hello fraglet!" <<'EOF'
;; Store string
(data (i32.const 0) "Hello fraglet!\n")

;; WASI entry point
(func $main (export "_start")
  ;; Set up iovec
  (i32.store (i32.const 16) (i32.const 0))
  (i32.store (i32.const 20) (i32.const 15))
  (call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
  drop

  ;; Exit with status 0
  (call $proc_exit (i32.const 0))
)
EOF

# Example 2: Multiple lines
verify_fraglet "Line 1" <<'EOF'
;; Store strings
(data (i32.const 0) "Line 1\n")
(data (i32.const 7) "Line 2\n")

;; WASI entry point
(func $main (export "_start")
  ;; Write first line
  (i32.store (i32.const 16) (i32.const 0))
  (i32.store (i32.const 20) (i32.const 7))
  (call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
  drop

  ;; Write second line
  (i32.store (i32.const 16) (i32.const 7))
  (i32.store (i32.const 20) (i32.const 7))
  (call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
  drop

  ;; Exit with status 0
  (call $proc_exit (i32.const 0))
)
EOF

# Example 3: Verify Line 2 appears
verify_fraglet "Line 2" <<'EOF'
;; Store strings
(data (i32.const 0) "Line 1\n")
(data (i32.const 7) "Line 2\n")

;; WASI entry point
(func $main (export "_start")
  ;; Write first line
  (i32.store (i32.const 16) (i32.const 0))
  (i32.store (i32.const 20) (i32.const 7))
  (call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
  drop

  ;; Write second line
  (i32.store (i32.const 16) (i32.const 7))
  (i32.store (i32.const 20) (i32.const 7))
  (call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
  drop

  ;; Exit with status 0
  (call $proc_exit (i32.const 0))
)
EOF

# Example 4: Longer message
verify_fraglet "Test message" <<'EOF'
;; Store longer string
(data (i32.const 0) "Test message here\n")

;; WASI entry point
(func $main (export "_start")
  ;; Set up iovec
  (i32.store (i32.const 16) (i32.const 0))
  (i32.store (i32.const 20) (i32.const 18))
  (call $fd_write (i32.const 1) (i32.const 16) (i32.const 1) (i32.const 24))
  drop

  ;; Exit with status 0
  (call $proc_exit (i32.const 0))
)
EOF

echo "✓ All tests passed"

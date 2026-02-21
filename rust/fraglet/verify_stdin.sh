#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Rust fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/rust:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.rs"
cat > "$tmp" <<'EOF'
use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    for line in stdin.lock().lines() {
        if let Ok(l) = line {
            println!("{}", l.to_uppercase());
        }
    }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"

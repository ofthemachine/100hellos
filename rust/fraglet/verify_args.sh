#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Rust fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/rust:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.rs"
cat > "$tmp" <<'EOF'
use std::env;

fn main() {
    let args: Vec<String> = env::args().skip(1).collect();
    println!("Args: {}", args.join(" "));
}
EOF
fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1 | grep -q "Args: foo bar baz"
echo "✓ args verified"

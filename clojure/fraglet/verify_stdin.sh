#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Clojure fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/clojure:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.clj"
cat > "$tmp" <<'EOF'
(require '[clojure.string :as str])
(doseq [line (line-seq (java.io.BufferedReader. *in*))]
  (println (str/upper-case line)))
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"

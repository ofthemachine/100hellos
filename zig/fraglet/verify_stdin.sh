#!/bin/bash
# verify_stdin.sh - Verified capability: stdin for Zig fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/zig:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.zig"
cat > "$tmp" <<'EOF'
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    const input = try std.io.getStdIn().readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(input);
    for (input) |c| {
        const out = [_]u8{std.ascii.toUpper(c)};
        _ = try std.io.getStdOut().writer().write(&out);
    }
}
EOF
echo "hello" | fragletc --image "$IMAGE" "$tmp" 2>&1 | grep -q "HELLO"
echo "✓ stdin verified"

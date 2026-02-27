#!/bin/bash
# verify_args.sh - Verified capability: argument passing for Zig fraglet.
set -euo pipefail
IMAGE="${1:-100hellos/zig:local}"
tmpdir=$(mktemp -d)
tmp="$tmpdir/fraglet.zig"
cat > "$tmp" <<'EOF'
pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var args = try std.process.argsWithAllocator(arena.allocator());
    defer args.deinit();
    _ = args.next();
    var list = std.ArrayList(u8).init(arena.allocator());
    while (args.next()) |arg| {
        if (list.items.len > 0) try list.appendSlice(" ");
        try list.appendSlice(arg);
    }
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Args: {s}\n", .{list.items});
}
EOF
output=$(fragletc --image "$IMAGE" "$tmp" foo bar baz 2>&1)
echo "$output" | grep -q "Args: foo bar baz"
echo "✓ args verified"

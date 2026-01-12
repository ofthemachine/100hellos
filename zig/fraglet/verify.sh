#!/bin/bash
# verify.sh - Smoke tests for zig fraglet support

set -euo pipefail

IMAGE="${1:-100hellos/zig:local}"

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
pub fn main() !void {
    std.debug.print("Hello from fragment!\n", .{});
}
EOF

# Example 2: Variables and calculations
verify_fraglet "Sum: 15" <<'EOF'
pub fn main() !void {
    const a: i32 = 5;
    const b: i32 = 10;
    std.debug.print("Sum: {}\n", .{a + b});
}
EOF

# Example 3: Functions
verify_fraglet "5 + 10 = 15" <<'EOF'
fn add(a: i32, b: i32) i32 {
    return a + b;
}

pub fn main() !void {
    const result = add(5, 10);
    std.debug.print("5 + 10 = {}\n", .{result});
}
EOF

# Example 4: Arrays and loops
verify_fraglet "Sum: 15" <<'EOF'
pub fn main() !void {
    const numbers = [_]i32{ 1, 2, 3, 4, 5 };
    var sum: i32 = 0;
    for (numbers) |n| {
        sum += n;
    }
    std.debug.print("Sum: {}\n", .{sum});
}
EOF

# Example 5: Structs
verify_fraglet "Alice is 30 years old" <<'EOF'
const Person = struct {
    name: []const u8,
    age: u32,
    
    fn greet(self: Person) void {
        std.debug.print("{s} is {} years old\n", .{ self.name, self.age });
    }
};

pub fn main() !void {
    const p = Person{ .name = "Alice", .age = 30 };
    p.greet();
}
EOF

# Example 6: Error handling
verify_fraglet "Result: 5" <<'EOF'
fn divide(a: i32, b: i32) !i32 {
    if (b == 0) return error.DivideByZero;
    return @divTrunc(a, b);
}

pub fn main() !void {
    const result = divide(10, 2) catch |err| {
        std.debug.print("Error: {}\n", .{err});
        return;
    };
    std.debug.print("Result: {}\n", .{result});
}
EOF

# Example 7: Optionals
verify_fraglet "Found at index: 2" <<'EOF'
fn findIndex(arr: []const i32, value: i32) ?usize {
    for (arr, 0..) |item, i| {
        if (item == value) return i;
    }
    return null;
}

pub fn main() !void {
    const arr = [_]i32{ 1, 2, 3, 4, 5 };
    if (findIndex(&arr, 3)) |index| {
        std.debug.print("Found at index: {}\n", .{index});
    } else {
        std.debug.print("Not found\n", .{});
    }
}
EOF

# Example 8: String operations
verify_fraglet "Hello World!" <<'EOF'
pub fn main() !void {
    const greeting = "Hello";
    const world = " World!";
    std.debug.print("{s}{s}\n", .{ greeting, world });
}
EOF

# Example 9: ArrayList
verify_fraglet "List length: 3" <<'EOF'
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    
    var list = std.ArrayList(i32).init(allocator);
    defer list.deinit();
    
    try list.append(1);
    try list.append(2);
    try list.append(3);
    
    std.debug.print("List length: {}\n", .{list.items.len});
}
EOF

echo "✓ All tests passed"

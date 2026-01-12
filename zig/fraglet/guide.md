# Zig Fraglet Guide

## Language Version
Zig 0.12.0

## Execution Model
- Compiled language using `zig run`
- Code is compiled and executed in one step using `zig run`
- Standard Zig execution model with `main()` function that returns an error union

## Key Characteristics
- Statically typed with type inference
- Memory-safe with manual memory management
- Zero-cost abstractions
- Compile-time code execution (comptime)
- Error handling via error unions (`!T`)
- Optional types (`?T`)
- Slices and pointers
- Case-sensitive
- Expression-based (most things are expressions)

## Fragment Authoring
Write valid Zig code. Your fragment can define functions, structs, enums, and the `main()` function. Your fragment will be compiled and executed.

## Available Libraries
The template includes the standard library (std), which provides:
- `std.debug.print` for output
- `std.fmt` for string formatting
- Collections: `ArrayList`, `HashMap`, `ArrayHashMap`
- String manipulation
- File I/O
- Networking
- Concurrency primitives
- Math operations
- And much more from the Zig standard library

## Common Patterns
- Print: `std.debug.print("message\n", .{})` or `std.debug.print("format {}\n", .{value})`
- Variables: `const x = 10;` or `var x: i32 = 10;` (mutable)
- Functions: `fn add(a: i32, b: i32) i32 { return a + b; }`
- Structs: `const Person = struct { name: []const u8, age: u32 };`
- Methods: Functions can be defined inside structs
- Arrays: `const arr = [_]i32{ 1, 2, 3 };` or `var list = std.ArrayList(i32).init(allocator);`
- Error handling: `fn mayFail() !i32 { return 42; }` or `try`, `catch`, `catch |err|`
- Optional: `?i32` for nullable values, `if (value) |v| { ... }`
- Slices: `[]const u8` for string slices, `[]i32` for integer slices
- Pointers: `*i32` for single value, `[*]i32` for many-item pointer

## Examples
```zig
// Simple output
pub fn main() !void {
    std.debug.print("Hello from fragment!\n", .{});
}

// Variables and calculations
pub fn main() !void {
    const a: i32 = 5;
    const b: i32 = 10;
    std.debug.print("Sum: {}\n", .{a + b});
}

// Functions
fn add(a: i32, b: i32) i32 {
    return a + b;
}

pub fn main() !void {
    const result = add(5, 10);
    std.debug.print("5 + 10 = {}\n", .{result});
}

// Arrays and loops
pub fn main() !void {
    const numbers = [_]i32{ 1, 2, 3, 4, 5 };
    var sum: i32 = 0;
    for (numbers) |n| {
        sum += n;
    }
    std.debug.print("Sum: {}\n", .{sum});
}

// Structs
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

// Error handling
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

// Optionals
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

// String operations
pub fn main() !void {
    const greeting = "Hello";
    const world = " World!";
    std.debug.print("{s}{s}\n", .{ greeting, world });
    std.debug.print("Length: {}\n", .{greeting.len});
}

// ArrayList
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
```

## Caveats
- Fragments must be valid Zig code that compiles
- Variables are immutable by default - use `var` for mutable variables
- Memory management is manual - use allocators for dynamic memory
- Error unions (`!T`) require error handling with `try` or `catch`
- Optional types (`?T`) require unwrapping with `if` or `orelse`
- String literals are `[]const u8` (slices)
- The code is compiled fresh each time, so compilation errors will fail execution
- Zig requires explicit error handling - functions that return error unions should handle errors
- Use `std.debug.print` for output, not `print` or `println`
- Format strings use `{}` for values and `{s}` for string slices
- Memory allocators are required for dynamic data structures like `ArrayList` and `HashMap`
- Always `defer` cleanup of allocated resources

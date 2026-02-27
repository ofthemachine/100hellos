const std = @import("std");
// BEGIN_FRAGLET
pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello World!\n", .{});
}
// END_FRAGLET
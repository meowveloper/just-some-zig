const std = @import("std");

fn max (comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

test "test max" {
    const n1 = max(u8, 10, 8);
    std.debug.print("n1 is {d}\n", .{n1});
    const n2 = max(f32, 84.44, 98.32);
    std.debug.print("n2 is {d}\n", .{n2});
}

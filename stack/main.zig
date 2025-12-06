const std: type = @import("std");
const Stack = @import("stack.zig").Stack;

pub fn main () !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const Stacku8 = Stack(u8);
    var stack_u8 = try Stacku8.init(allocator, 10);
    defer stack_u8.deinit();

    try stack_u8.push(1);
    try stack_u8.push(2);
    try stack_u8.push(3);
    try stack_u8.push(4);
    try stack_u8.push(5);
    try stack_u8.push(6);

    std.debug.print("stack length: {d}\n", .{stack_u8.length});
    std.debug.print("stack capacity: {d}\n", .{stack_u8.capacity});

    stack_u8.pop();
    std.debug.print("stack length: {d}\n", .{stack_u8.length});

    stack_u8.pop();
    std.debug.print("stack length: {d}\n", .{stack_u8.length});

    std.debug.print("stack state: {any}\n", .{stack_u8.items[0..stack_u8.length]});
}

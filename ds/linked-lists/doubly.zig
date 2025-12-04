const std = @import("std");

const NodeU32 = struct {
    data: u32,
    node: std.DoublyLinkedList.Node = .{}
};


pub fn main() !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    var list: std.DoublyLinkedList = .{};

    var one = NodeU32{.data = 1};
    var two = NodeU32{.data = 2};
    var three = NodeU32{.data = 3};
    var five = NodeU32{.data = 5};

    list.append(&one.node);
    list.append(&five.node);
    list.insertAfter(&one.node, &three.node);
    list.append(&two.node);

    try stdout.print("number of nodes: {}", .{list.len()});
    try stdout.flush();
}

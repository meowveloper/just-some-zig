const std = @import("std");

const NodeU32 = struct {
    data: u32,
    node: std.SinglyLinkedList.Node = .{}
};

pub fn main () !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    var one = NodeU32{.data = 1};
    var two = NodeU32{.data = 2};
    var three = NodeU32{.data = 3};
    var five = NodeU32{.data = 5};

    var list: std.SinglyLinkedList = .{};

    list.prepend(&two.node);
    two.node.insertAfter(&five.node);
    two.node.insertAfter(&three.node);
    list.prepend(&one.node);

    try stdout.print("Number of nodes {}.\n", .{list.len()});
    try stdout.flush();

    var it = list.first;
    while (it) |node| : (it = node.next) {
        const l: *NodeU32 = @fieldParentPtr("node", node);
        try stdout.print("current value: {}.\n", .{ l.data });
    }
    try stdout.flush();
}

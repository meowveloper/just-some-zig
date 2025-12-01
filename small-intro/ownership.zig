const std = @import("std");
const builtin = @import("builtin");

pub fn main () !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var lookup = std.StringHashMap(User).init(allocator);
    defer {
        var it = lookup.keyIterator();
        while (it.next()) |key| {
            allocator.free(key.*);
        }
        lookup.deinit();
    }

    var buf : [30]u8 = undefined;
    var stdin = std.fs.File.stdin().reader(&buf);

    var stdout = std.fs.File.stdout().writer(&.{});

    var i: i32 = 0;

    while (true): (i += 1) {
        try stdout.interface.print("please enter a name: ", .{});
        var name = try stdin.interface.takeDelimiterExclusive('\n');
        stdin.interface.toss(1);

        if(builtin.os.tag == .windows) {
            name = @constCast(std.mem.trimRight(u8, name, "\r"));
        }

        if(name.len == 0) {
            break;
        }

        const owned_name = try allocator.dupe(u8, name);
        try lookup.put(owned_name, .{.power = i});
    }

    var it = lookup.iterator();
    while (it.next()) |kv| {
        std.debug.print("{s} == {any}\n", .{kv.key_ptr.*, kv.value_ptr.*});
    }

    const has_leto = lookup.contains("Leto");
    std.debug.print("\n{any}\n", .{has_leto});
}

const User = struct {
    power: i32
};

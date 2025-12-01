const std = @import("std");
const builtin = @import("builtin");


pub fn main () !void {
    var gpa : std.heap.GeneralPurposeAllocator(.{}) = .init;
    const allocator = gpa.allocator();

    var arr : std.ArrayList(User) = .empty;
    defer {
        for (arr.items) |user| {
            user.deinit(allocator);
        }
        arr.deinit(allocator);
    }

    var buf: [30]u8 = undefined;
    var stdin = std.fs.File.stdin().reader(&buf);
    var stdout = std.fs.File.stdout().writer(&.{});

    var i: i32 = 0;
    while (true): (i += 1) {
        try stdout.interface.print("Please enter a name: ", .{});
        var name = try stdin.interface.takeDelimiterExclusive('\n');
        stdin.interface.toss(1);

        if(builtin.os.tag == .windows) {
            name = std.mem.trimRight(u8, name, "\r");
        }

        if(name.len == 0) break;

        const own_name = try allocator.dupe(u8, name);
        try arr.append(allocator, .{.name = own_name, .power = i});
    }

    var has_leto = false;
    for (arr.items) |user| {
        if(std.mem.eql(u8, user.name, "Leto")) {
            has_leto = true;
            break;
        }
    }
    std.debug.print("\n{any}\n", .{has_leto});
    
}

const User = struct {
    name: []const u8,
    power: i32,

    fn deinit (self: User, allocator: std.mem.Allocator) void {
        allocator.free(self.name);
    }
};

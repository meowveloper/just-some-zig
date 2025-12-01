const std = @import("std");

pub fn main() !void {
    var gpd = std.heap.DebugAllocator(.{}){};
    const allocator = gpd.allocator();

    var user = try allocator.create(User);
    defer allocator.destroy(user);

    user.id = 1;
    user.power = 100;

    user.levelUp();

    std.debug.print("user {d} has power {d}\n", .{user.id, user.power});
}

const User = struct {
    id: u64,
    power: i32,

    fn levelUp (user: *User) void {
        user.power += 1;
    }
};

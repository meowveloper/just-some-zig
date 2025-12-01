const std = @import("std");

pub fn main () void {
    const the_manager = User{
        .id = 1,
        .power = 100,
        .name = "Goku"
    };

    const luu = User{
        .id = 2,
        .power = 20,
        .name = "luu",
        .manager = &the_manager
    };
    std.debug.print("{any}\n{any}", .{the_manager, luu});
}


const User = struct {
    id: u64,
    power: i32,
    name: []const u8,
    manager: ?*const User = null,

    fn levelUp(user: *User) void {
        user.power += 1;
    }
};

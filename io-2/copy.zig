const std = @import("std");

pub fn main () !void {
    const cwd = std.fs.cwd();

    try cwd.copyFile("copieds/foo.txt", cwd, "foo-2.txt", .{});
}

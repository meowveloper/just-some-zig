const std = @import("std");
const cwd = std.fs.cwd();

pub fn main () !void {

    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    var dir = try cwd.openDir(".", .{ .iterate = true });
    var it = dir.iterate();
    while (try it.next()) |entry| {
        try stdout.print("file name: {s}\n", .{ entry.name });
    }
    try stdout.flush();
}

const std = @import("std");

pub fn main () !void {
    const cwd = std.fs.cwd();

    const file = try cwd.openFile("foo.txt", .{ .mode = .read_only });
    defer file.close();

    var read_buffer: [1024]u8 = undefined;
    const io = std.testing.io;
    var fr = file.reader(io, &read_buffer);
    var file_reader = &fr.interface;

    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    var buffer: [300]u8 = undefined;
    @memset(buffer[0..], 0);

    _ = file_reader.readSliceAll(buffer[0..]) catch 0;

    try stdout.print("{s}\n", .{buffer});
    try stdout.flush();
}

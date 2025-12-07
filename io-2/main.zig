const std = @import("std");
const io = std.testing.io;
const cwd = std.fs.cwd();

pub fn main () !void {
    const foo_file = try cwd.createFile("foo.txt", .{ .read = true });
    defer foo_file.close();

    _ = try foo_file.writeAll("writing this line to the file\n");

    var buffer: [300]u8 = undefined;
    @memset(buffer[0..], 0);

    try foo_file.seekTo(0);
    var read_buffer: [1024]u8 = undefined;
    var fr = foo_file.reader(io, &read_buffer);
    var reader = &fr.interface;

    _ = reader.readSliceAll(buffer[0..]) catch 0;

    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    try stdout.print("{s}\n", .{buffer});
    try stdout.flush();
}

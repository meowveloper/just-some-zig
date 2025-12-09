const std = @import("std");

var stdout_buffer: [1024]u8 = undefined;
var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
const stdout = &stdout_writer.interface;

const Thread = std.Thread;
const io = std.testing.io;
const clock: std.Io.Clock = .awake;

pub fn main () !void {
    const thread = try Thread.spawn(.{}, do_some_work, .{});
    thread.join();
}

fn do_some_work () !void {
    _ = try stdout.write("starting the work. \n");
    try stdout.flush();

    const duration = std.Io.Duration { .nanoseconds = 1000 };
    try std.Io.sleep(io, duration, clock);
    _ = try stdout.write("finishing the work. \n");
    try stdout.flush();
}

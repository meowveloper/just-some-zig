const std = @import("std");
const Person = struct {
    name: []const u8,
    age: u8,
    height: f32
};

const PersonArray = std.MultiArrayList(Person);

pub fn main () !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var people = PersonArray{};
    defer people.deinit(allocator);

    try people.append(allocator, .{ .name = "Zwe", .age = 23, .height = 1.54 });
    try people.append(allocator, .{ .name = "Khant", .age = 24, .height = 1.54 });
    try people.append(allocator, .{ .name = "Aung", .age = 25, .height = 1.54 });

    var people_slice = people.slice();
    for (people_slice.items(.name), people_slice.items(.age)) |*name, *age| {
        age.* += 10;
        try stdout.print("name: {s}, age: {d}\n", .{name.*, age.*});
    }

    try stdout.flush();
}

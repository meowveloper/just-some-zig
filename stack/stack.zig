const std: type = @import("std");
const Allocator: type = std.mem.Allocator;

pub const Stack: type = struct {
    items: []u32,
    capacity: usize,
    length: usize,
    allocator: Allocator,

    pub fn init(allocator: Allocator, capacity: usize) !@This() {
        var buffer = try allocator.alloc(u32, capacity);

        return .{
            .items = buffer[0..],
            .capacity = capacity,
            .length = 0,
            .allocator = allocator
        };
    }

    pub fn push (self: *@This(), val: u32) !void {
        if ((self.length + 1) > self.capacity) {
            var new_buffer = try self.allocator.alloc(u32, self.capacity * 2);

            @memcpy(new_buffer[0..self.capacity], self.items);
            self.allocator.free(self.items);
            self.items = new_buffer;
            self.capacity = self.capacity * 2;
        }

        self.items[self.length] = val;
        self.length += 1;
    }

    pub fn pop (self: *@This()) void {
        if(self.length == 0) return;
        self.items[self.length - 1] = undefined;
        self.length -= 1;
    }

    pub fn deinit(self: *@This()) void {
        self.allocator.free(self.items);
    }
};

const std = @import("std");

pub fn main () !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    const allocator = gpa.allocator();

    var list = try List(u32).init(allocator);
    defer list.deinit();

    for (0..10) |i| {
        try list.add(@intCast(i));
    }

    std.debug.print("{any}\n", .{list.items[0..list.pos]});
}


fn List(comptime T : type) type {
    return struct {
        pos : usize,
        items : []T,
        allocator : std.mem.Allocator,

        const Self = @This(); // this is the same as List(T);

        fn init (allocator: std.mem.Allocator) !Self {
            return .{
                .pos = 0,
                .allocator = allocator,
                .items = try allocator.alloc(T, 4)
            };
        }

        fn deinit (self: Self) void {
            self.allocator.free(self.items);
        }

        fn add (self: *Self, val: T) !void {
            const pos = self.pos;
            const len = self.items.len;

            if(pos == len) {
                var larger = try self.allocator.alloc(T, len * 2);
                @memcpy(larger[0..len], self.items);
                self.deinit();
                self.items = larger;
            }

            self.items[pos] = val;
            self.pos = pos + 1;
        }
    };
}

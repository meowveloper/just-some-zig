const std = @import("std");
const AutoHashMap = std.hash_map.AutoHashMap;


pub fn main () !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var hash_table = AutoHashMap(u32, u8).init(allocator);

    defer hash_table.deinit();

    try hash_table.put(54321, 89);
    try hash_table.put(50050, 55);
    try hash_table.put(57709, 41);

    std.debug.print("N of items stored: {d}\n", .{hash_table.count()});

    std.debug.print("Value at 50050: {d}\n", .{hash_table.get(50050).?});

    if(hash_table.remove(57709)) {
        std.debug.print("value at 57709 successfully removed", .{});
    }
    std.debug.print("N of items stored: {d}\n", .{hash_table.count()});


    var it = hash_table.iterator();
    while(it.next()) |kv| {
        std.debug.print("key: {d} | ", .{kv.key_ptr.*});
        std.debug.print("value: {d}\n", .{kv.value_ptr.*});
    }

    var ages = std.StringHashMap(u8).init(allocator);
    defer ages.deinit();
    
    try ages.put("hi", 30);
    try ages.put("hello", 40);
    try ages.put("hey", 50);

    var st_it = ages.iterator();
    while(st_it.next()) |kv| {
        std.debug.print("key: {s} | ", .{kv.key_ptr.*});
        std.debug.print("value: {d}\n", .{kv.value_ptr.*});
    }
}

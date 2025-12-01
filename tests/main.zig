const std = @import("std");
const Allocator = std.mem.Allocator; 

test "testing simple sum" {
    const a: u8 = 4;
    const b: u8 = 2;
    try std.testing.expect((a + b) == 6);
}


test "arrays are equal?" {
    const arr1 = [3]u32{1,2,3};
    const arr2 = [3]u32{1,2,3};
    try std.testing.expectEqualSlices(u32, &arr1, &arr2);
}



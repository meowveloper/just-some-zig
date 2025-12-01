const std = @import("std");

test "string are equal?" {
    const str1 = "hello, world!";
    const str2 = "Hello, world!";

    try std.testing.expectEqualStrings(str1, str2);
}

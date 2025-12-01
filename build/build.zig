const std = @import("std");

pub fn build (b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "hello",
        .root_module = b.createModule(.{
            .root_source_file = b.path("hello.zig"),
            .target = b.graph.host,
            .optimize = .ReleaseSafe
        }),
        .version = .{
            .major = 2, .minor = 9, .patch = 7
        }
    });

    b.installArtifact(exe);
    const run_arti = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run the project");

    run_step.dependOn(&run_arti.step);
}

const std = @import("std");

pub fn build(b: *std.Build) void {
    var target = b.standardTargetOptions(.{});
    target.cpu_arch = .x86_64;
    target.os_tag = .freestanding;

    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "mini-zos",
        .root_source_file = .{ .path = "./kernel/mini-zos.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.setLinkerScript(.{ .path = "./kernel/linker.ld" });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Build mini-zos");
    run_step.dependOn(&run_cmd.step);
}

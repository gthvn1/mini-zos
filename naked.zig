const startInfo = @import("start_info.zig");

export var stack: [8 * 1024]u8 align(16) linksection(".bss") = undefined;
var stack_top: usize = undefined;

export fn _start() callconv(.Naked) noreturn {
    stack_top = @intFromPtr(&stack) + stack.len;
    asm volatile (""
        :
        : [stack_top] "{rsp}" (stack_top),
    );
    while (true) {}
}

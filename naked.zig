const startInfo = @import("start_info.zig");

export var stack: [8 * 1024]u8 align(16) linksection(".bss") = undefined;
var stack_top: usize = undefined;

// Hypercall is done by mapping an hypercall page in mini-zos address
// space. The hypercall_page will be filled by Xen when it will load
// us. We just need to keep space at 0x3000
// Look in xen source: xen/arch/x86/guest/xen/hypercall_page.S
export var hypercall_page: [4 * 1024]u8 linksection(".hypercall_page") = undefined;

export fn _start() callconv(.Naked) noreturn {
    stack_top = @intFromPtr(&stack) + stack.len;
    asm volatile (""
        :
        : [stack_top] "{rsp}" (stack_top),
    );
    while (true) {}
}

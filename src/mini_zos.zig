const startInfo = @import("start_info.zig");

// the stack should be aligned to 16-bytes boundary.
export var stack: [8 * 1024]u8 align(16) linksection(".bss") = undefined;

// Hypercall is done by mapping an hypercall page in mini-zos address
// space. The hypercall_page will be filled by Xen when it will load
// us. We just need to keep space at 0x3000
// Look in xen source: xen/arch/x86/guest/xen/hypercall_page.S
export var hypercall_page: [4 * 1024]u8 linksection(".hypercall_page") = undefined;

// See modifiers for inline asm
// https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#x86Operandmodifiers
export fn _start() callconv(.Naked) noreturn {
    const stack_top: usize = @intFromPtr(&stack) + stack.len;
    asm volatile (
        \\mov %[stack_top], %%rsp
        \\call %[kernelStart:P]
        : // output operands
        : [stack_top] "r" (stack_top), //input operands
          [kernelStart] "X" (&kMain),
        : "rsp " //Clobbers
    );

    while (true)
        asm volatile ("hlt");
}

fn kMain() void {
    // add nop nop to help to spot it if disassemble...
    asm volatile ("nop; nop");
}

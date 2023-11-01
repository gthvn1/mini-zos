const startInfo = @import("startinfo.zig");
const elfNote = @import("elfnotes.zig");

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

    //elfNote.gen("Xen", "2", ".quad TODO:hypercall_page"); // hypercall_page should be replaced by its value
    elfNote.gen_asciz("Xen", "5", "xen-3.0");
    elfNote.gen_asciz("Xen", "6", "Mini-ZOS");
    elfNote.gen_asciz("Xen", "8", "generic");

    const stack_top: usize = @intFromPtr(&stack) + stack.len;
    asm volatile (
        \\call %[kmain:P]
        : // output operands
        : [_] "{rsp}" (stack_top), //input operands [setup the stack]
          [kmain] "X" (&kMain),
    );

    while (true)
        asm volatile ("hlt");
}

fn kMain() void {
    // add nop nop to help to spot the code when objdumped...
    asm volatile ("nop; nop");
}

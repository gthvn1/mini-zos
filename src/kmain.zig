const startInfo = @import("startinfo.zig");
const elfNote = @import("elfnotes.zig");

// the stack should be aligned to 16-bytes boundary.
export var stack: [8 * 1024]u8 align(16) linksection(".bss") = undefined;

extern const hypercall_page: usize;
extern const shared_info: usize;

export fn _start() callconv(.Naked) noreturn {
    const stack_top: usize = @intFromPtr(&stack) + stack.len;

    // See modifiers for inline asm
    // https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#x86Operandmodifiers
    asm volatile (
        \\call %[kmain:P]
        : // output operands
        : [_] "{rsp}" (stack_top), //input operands [setup the stack]
          [kmain] "X" (&kMain),
    );

    elfNote.genXen(.xen_version, "xen-3.0");
    elfNote.genXen(.guest_os, "Mini-ZOS");
    elfNote.genXen(.loader, "generic");
    // Need to make room for the shared info page and hypercall page.
    // Look in xen source: xen/arch/x86/guest/xen/hypercall_page.S
    asm volatile (
        \\
        \\    .pushsection .note.Xen
        \\    .align 4
        \\    .long 2f - 1f
        \\    .long 4f - 3f
        \\    .long 2
        \\1:.asciz #Xen
        \\2:.align 4
        \\3:.quad hypercall_page
        \\4:.align 4
        \\    .popsection
        \\
        \\.globl shared_info, hypercall_page
        \\    .align 4096
        \\shared_info:
        \\    .fill 4096,1,0
        \\hypercall_page:
        \\    .fill 4096,1,0
    );

    while (true)
        asm volatile ("hlt");
}

fn kMain() void {
    // add nop nop to help to spot the code when objdumped...
    asm volatile ("nop; nop");
}

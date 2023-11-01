// The notes should live in a PT_NOTE segment and have "Xen" in the name field
// ASCIZ type are string NULL terminated.

pub inline fn gen_asciz(comptime name: []const u8, comptime typ: []const u8, comptime desc: []const u8) void {
    asm volatile ("    .pushsection .note." ++ name ++ "\n" ++
            "    .align 4\n" ++
            "    .long 2f - 1f\n" ++ // name size
            "    .long 4f - 3f\n" ++ // desc size
            "    .long " ++ typ ++ "\n" ++ // type
            "1:.asciz #" ++ name ++ "Xen\n" ++
            "2:.align 4\n" ++
            "3:.asciz \"" ++ desc ++ "\"\n" ++
            "4:.align 4\n" ++
            "    .popsection\n");
}

// The notes should live in a PT_NOTE segment and have "Xen" in the name field
// ASCIZ type are string NULL terminated.

// See mini-os include/xen/elfnote.h
const XenElfNote = enum {
    hypercall_page,
    xen_version,
    guest_os,
    loader,

    pub fn toString(note: XenElfNote) []const u8 {
        return switch (note) {
            .hypercall_page => "2",
            .xen_version => "5",
            .guest_os => "6",
            .loader => "8",
        };
    }
};

inline fn toHexString(comptime value: usize) []const u8 {
    _ = value;

    return "0xFFFFFFFF";
}

pub inline fn genXenLong(comptime value: XenElfNote, comptime desc: usize) void {
    const desc_string = toHexString(desc);

    asm volatile ("    .pushsection .note.Xen\n" ++
            "    .align 4\n" ++
            "    .long 2f - 1f\n" ++ // name size
            "    .long 4f - 3f\n" ++ // desc size
            "    .long " ++ value.toString() ++ "\n" ++ // type
            "1:.asciz #Xen\n" ++
            "2:.align 4\n" ++
            "3:.long \"" ++ desc_string ++ "\"\n" ++
            "4:.align 4\n" ++
            "    .popsection\n");
}
pub inline fn genXenAsciz(comptime value: XenElfNote, comptime desc: []const u8) void {
    asm volatile ("    .pushsection .note.Xen\n" ++
            "    .align 4\n" ++
            "    .long 2f - 1f\n" ++ // name size
            "    .long 4f - 3f\n" ++ // desc size
            "    .long " ++ value.toString() ++ "\n" ++ // type
            "1:.asciz #Xen\n" ++
            "2:.align 4\n" ++
            "3:.asciz \"" ++ desc ++ "\"\n" ++
            "4:.align 4\n" ++
            "    .popsection\n");
}

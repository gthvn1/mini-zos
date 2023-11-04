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

    pub inline fn pushsection() []const u8 {
        return 
        \\    .pushsection .note.Xen
        \\    .align 4
        \\    .long 2f - 1f
        \\    .long 4f - 3f
        \\
        ;
    }

    pub inline fn middlesection() []const u8 {
        return 
        \\1:.asciz #Xen
        \\2:.align 4
        \\
        ;
    }
    pub inline fn popsection() []const u8 {
        return 
        \\4:.align 4
        \\    .popsection
        \\
        ;
    }
};

pub inline fn genXen(comptime value: XenElfNote, comptime desc: []const u8) void {
    asm volatile (XenElfNote.pushsection() ++
            "    .long " ++ value.toString() ++ "\n" ++ // type
            XenElfNote.middlesection() ++
            "3:.asciz \"" ++ desc ++ "\"\n" ++
            XenElfNote.popsection());
}

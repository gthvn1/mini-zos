/// The initial memory of a new domain created by Xen contains the start info
/// page. This page will be mapped by mini-zos in its address space.
const ConsoleDom0 = struct {
    info_off: u32, // Offset of console_info struct.
    info_size: u32, // Size of console_info struct from start
};

const ConsoleDomU = struct {
    mfn: u64, // Machine Page Number of console page
    evtchn: u32, // Event channel for console page
};

const Console = union {
    domU: ConsoleDomU,
    dom0: ConsoleDom0,
};

const StartInfo = struct {
    magic: [32]u8, // xen-<version>-<platform>
    nr_pages: u64, // Total pages allocated to this domain
    shared_info: u64, // MACHINE address of shared info page structure
    flags: u32, // SIF_xxx flags
    store_mfn: u64, // MACHINE page number of shared page
    store_evtchn: u32, // Event channel for store communication
    console: Console,
    // THE FOLLOWING ARE ONLY FILLED IN ON INITIAL BOOT (NOT RESUME).
    pt_base: u64, // VIRTUAL address of page directory.
    nr_pt_frames: u64, // Number of bootstrap p.t. frames.
    mfn_list: u64, // VIRTUAL address of page-frame list.
    mod_start: u64, // VIRTUAL address of pre-loaded module.
    //(PFN of pre-loaded module if SIF_MOD_START_PFN set in flags).
    mod_len: u64, // Size (bytes) of pre-loaded module.
    // #define MAX_GUEST_CMDLINE 1024
    cmd_line: [1024]u8,
    // The pfn range here covers both page table and p->m table frames.
    first_p2m_pfn: u64, // 1st pfn forming initial P->M table.
    nr_p2m_frames: u64, // # of pfns forming initial P->M table.
};

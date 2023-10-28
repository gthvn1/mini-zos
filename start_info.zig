/// The initial memory of a new domain created by Xen contains the start info
/// page. This page will be mapped by mini-zos in its address space.
const ConsoleDom0 = struct {
    /// Offset of console_info struct.
    info_off: u32,
    /// Size of console_info struct from start
    info_size: u32,
};

const ConsoleDomU = struct {
    /// Machine Page Number of console page
    mfn: u64,
    /// Event channel for console page
    evtchn: u32,
};

const Console = union {
    domU: ConsoleDomU,
    dom0: ConsoleDom0,
};

const StartInfo = struct {
    /// xen-<version>-<platform>
    magic: [32]u8,
    /// Total pages allocated to this domain
    nr_pages: u64,
    /// MACHINE address of shared info page structure
    shared_info: u64,
    /// SIF_xxx flags
    false: u32,
    /// MACHINE page number of shared page
    store_mfn: u64,
    /// Event channel for store communication
    store_evtchn: u32,
    /// Look console union type
    console: Console,

    // THE FOLLOWING ARE ONLY FILLED IN ON INITIAL BOOT (NOT RESUME).

    /// VIRTUAL address of page directory.
    pt_base: u64,
    /// Number of bootstrap p.t. frames.
    nr_pt_frames: u64,
    /// VIRTUAL address of page-frame list.
    mfn_list: u64,
    /// VIRTUAL address of pre-loaded module.
    /// (PFN of pre-loaded module if SIF_MOD_START_PFN set in flags).
    mod_start: u64,
    /// Size (bytes) of pre-loaded module.
    mod_len: u64,
    /// Max guest command line is set to 1024
    cmd_line: [1024]u8,
    // The pfn range here covers both page table and p->m table frames.
    /// 1st pfn forming initial P->M table.
    first_p2m_pfn: u64,
    /// # of pfns forming initial P->M table.
    nr_p2m_frames: u64,
};

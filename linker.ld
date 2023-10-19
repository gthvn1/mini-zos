ENTRY(_start)

SECTIONS {
    . = 0x10000;   /* Set the starting address to 0x10000 */
    .text : {     /* .text section contains program code */
        *(.text)  /* Merge all .text sections from input files */
    }

    .data : {     /* .data section contains initialized data */
        *(.data)  /* Merge all .data sections from input files */
    }

    .bss : {      /* .bss section contains uninitialized data */
        *(.bss)   /* Merge all .bss sections from input files */
    }

    /* Define additional sections as needed */
    /* For example: .rodata, .rodata1, .data.rel, .data.rel.ro, etc. */
}

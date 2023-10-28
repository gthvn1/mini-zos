# Mini-Zos

Inspired by mini-os that is a small OS kernel running on Xen hypervisor.

- [Mini-OS source code](http://xenbits.xen.org/gitweb/?p=mini-os.git;a=summary)
- [Some notes about the original Mini-OS](https://wiki.xenproject.org/wiki/Mini-OS-DevNotes)

# Cool links

- [Zig Bare Bones](https://wiki.osdev.org/Zig_Bare_Bones)
- [Zig Live Coding - "Hello world" x86 kernel](https://vimeo.com/483928663) - Andrew Kelley

# Build

- Just run `zig build -Doptimize=ReleaseSmall`
- the build will produce a binary **zig-out/bin/mini-zos**

# Tadam...

```asm
via ❄️  impure (nix-shell) ❯ objdump -d zig-out/bin/mini-zos

zig-out/bin/mini-zos:     file format elf64-x86-64


Disassembly of section .text:

0000000000010000 <.text>:
   10000:       bc 10 20 01 00          mov    $0x12010,%esp
   10005:       eb fe                   jmp    0x10005
```

# The ultimate goal

The ultimate goal is to run a unikernel written in zig that runs on top of Xen and provides runtime for Wasm binaries...
Cool no :)

# Web Assembly

Look into the repo `wasm_apps` to have a little sneak peek of *Wasm*.

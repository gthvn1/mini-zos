# Mini-Zos

Inspired by mini-os that is a small OS kernel running on Xen hypervisor.

- [Mini-OS source code](http://xenbits.xen.org/gitweb/?p=mini-os.git;a=summary)
- [Some notes about the original Mini-OS](https://wiki.xenproject.org/wiki/Mini-OS-DevNotes)

# Cool links

- [Zig Bare Bones](https://wiki.osdev.org/Zig_Bare_Bones)
- [Zig Live Coding - "Hello world" x86 kernel](https://vimeo.com/483928663) - Andrew Kelley

# Build

- We are targeting the native x86_64 architecture.
- Just run `zig build -Doptimize=ReleaseSmall`
- the build will produce a binary **zig-out/bin/mini-zos**

# Tadam...

```asm
via ❄️  impure (nix-shell) ❯ objdump -d zig-out/bin/mini-zos

zig-out/bin/mini-zos:     file format elf64-x86-64


Disassembly of section .text:

0000000000010000 <.text>:
   10000:       b8 00 30 01 00          mov    $0x13000,%eax
   10005:       48 89 c4                mov    %rax,%rsp
   10008:       e8 03 00 00 00          call   0x10010
   1000d:       f4                      hlt
   1000e:       eb fd                   jmp    0x1000d
   10010:       90                      nop
   10011:       90                      nop
   10012:       c3                      ret
```

# The ultimate goal

The ultimate goal is to run a unikernel written in zig that runs on top of Xen and provides runtime for Wasm binaries...
Cool no :)

# Web Assembly

Look into the repo `wasm_apps` to have a little sneak peek of *Wasm*.

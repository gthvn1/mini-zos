# Mini-Zos

Inspired by mini-os that is a small OS kernel running on Xen hypervisor.

- [Some notes about the original mini-os](https://wiki.xenproject.org/wiki/Mini-OS-DevNotes)

# Cool links

- [Zig Live Coding - "Hello world" x86 kernel](https://vimeo.com/483928663) - Andrew Kelley

# Build

`zig build-exe naked.zig -target x86_64-freestanding -static -Tlinker.ld`

# Tadam...

```asm
via ❄️  impure (shell) ❯ objdump -d naked

naked:     file format elf64-x86-64


Disassembly of section .text:

0000000000010000 <_start>:
   10000:       eb 00                   jmp    10002 <_start+0x2>
   10002:       eb fe                   jmp    10002 <_start+0x2>
```

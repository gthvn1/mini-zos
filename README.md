# Mini-Zos

Inspired by mini-os that is a small OS kernel running on Xen hypervisor.

- [Some notes about the original mini-os](https://wiki.xenproject.org/wiki/Mini-OS-DevNotes)

# Build

`zig build-exe naked.zig -target x86_64-freestanding -static -Tlinker.ld`

.PHONY: all clean

all:
	zig build-exe mini-zos.zig -target x86_64-freestanding -static -Tlinker.ld

clean:
	rm -f mini-zos mini-zos.o

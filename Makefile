.PHONY: all clean

all:
	zig build-exe naked.zig -target x86_64-freestanding -static -Tlinker.ld

clean:
	rm -f naked naked.o
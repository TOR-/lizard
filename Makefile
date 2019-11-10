OBJ=floppyA

KERNEL_CFLAGS=--std=gnu11

KERNEL_SRCDIR=.
KERNEL_OBJS=\
$(KERNEL_SRCDIR)/kernel.o\
$(KERNEL_SRCDIR)/screen.o\
$(KERNEL_SRCDIR)/gdt.o\
$(KERNEL_SRCDIR)/lib.o\
$(KERNEL_SRCDIR)/logging.o\
$(KERNEL_SRCDIR)/string.o

CC=i686-pc-elf-gcc
LD=i686-pc-elf-ld

all: $(OBJ) 

floppyA: bootsect kernel
	cat bootsect kernel /dev/zero | dd of=floppyA bs=512 count=2880

kernel: $(KERNEL_OBJS)
	$(LD) --oformat binary -Ttext 1000 $(KERNEL_OBJS) -o kernel

#kernel.o: kernel.asm 
#	nasm -f elf32 -o $@ $^

bootsect: bootsect.asm
	nasm -f bin -o $@ $^

%.o: %.c 
	$(CC) $(KERNEL_CFLAGS) -c $^

clean:
	rm -f $(OBJ) *.o bootsect kernel

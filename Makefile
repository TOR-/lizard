OBJ=floppyA
CC=i686-elf-gcc

all: $(OBJ) 

floppyA: bootsect kernel
	cat bootsect kernel /dev/zero | dd of=floppyA bs=512 count=2880

kernel: kernel.o screen.o
	i686-elf-ld --oformat binary -Ttext 1000 kernel.o screen.o -o kernel

#kernel.o: kernel.asm 
#	nasm -f elf32 -o $@ $^

bootsect: bootsect.asm
	nasm -f bin -o $@ $^

.o: .c 
	$(CC) -c $^

clean:
	rm -f $(OBJ) *.o bootsect kernel

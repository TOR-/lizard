i686-elf-gcc -c screen.c
i686-elf-gcc -c kernel.c
#nasm -f elf -I kern -o kernel.o kern/kernel.asm
i686-elf-ld --oformat binary -Ttext 1000 kernel.o screen.o -o kernel
nasm -f bin -I kern -o bootsect bootsect.asm
cat bootsect kernel /dev/zero | dd of=floppyA bs=512 count=2880

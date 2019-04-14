nasm -f bin -o bootsect bootsect.asm
nasm -f bin -o kernel kernel.asm
cat bootsect kernel /dev/zero | dd of=floppyA bs=512 count=2880

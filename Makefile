# MACRO: 使用什么命令建立？
ASM	= nasm
CC	= gcc
LD 	= ld

# MACRO: 命令参数有哪些？
ASSEMBLE_FLAGS 	= -f elf32
GCC_FLAGS   := -c -Os -std=c99 -m32 -Wall -Wextra -Werror -fno-pie -fno-stack-protector -fomit-frame-pointer -fno-builtin -fno-common -ffreestanding
LD_FLAGS		= -s -static -T layout.ld -n -m elf_i386

# MACRO: 有哪些中间文件？
OS_OBJS	= entry.o main.o vgastr.o
OS_TARGET  = imporium.img

.PHONY : build clean all link bin

all: clean build run

clean:
	rm -f $(OS_OS_TARGET) $(OS_OBJS)

build: $(OS_OBJS)

run: $(OS_TARGET)
	qemu-system-x86_64 -curses -drive 'file=$<,format=raw,index=0,media=disk'

$(OS_TARGET):$(OS_OBJS)
	$(LD) $(LD_FLAGS) -o $@ $^

%.o : %.asm
	$(ASM) $(ASSEMBLE_FLAGS) -o $@ $<
%.o : %.c
	$(CC) $(GCC_FLAGS) -o $@ $<
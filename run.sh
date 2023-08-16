#!/bin/bash
set -xue

# QEMU file path
QEMU=qemu-system-riscv32

# clang path
CC=clang

CFLAGS="-std=c11 -O2 -g3 -Wall -Wexstra --target=riscv32 -ffreestanding -nostdlib"

$CC $CFLAGS -Wl,-Tkernel.ld -Wl,-Map=kernel.map -o kernel.elf \
    kernel.c

# launch QEMU
$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot \
    -kernel kernel.elf

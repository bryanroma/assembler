; hello_world.asm
;
; Author: Bryan Rodriguez (just an earthling)
; Date: who cares?
; To compile:
; 	nasm -f elf32 -o hello_world.o hello_world.asm
;	ld -m elf_i386 -o hello_world.bin hello_world.o


; _start as global variable
global _start

; define text section for adding code
section .text:

; define _start
_start:

	; register sanitization
	xor ecx, ecx 			; clearing ECX
	xor ebx, ebx			; clearing EBX
	mul ecx				; clearing EAX, EDX

	; After clearing the above register, let's move
	mov eax, 0x4			; Move Write syscall number into EAX (locate unistd_32.h)
	mov ebx, 0x1			; Move file descriptor into EBX
	mov ecx, message		; Move buffer into ECX
	mov edx, message_length		; Move the count into EDX
	int 0x80			; syscall 80 (Interrup)

	; exit like a boss 
	
	mov eax, 0x1 			; Moving Exit syscall into EAX
	mov ebx, 0			; Moving status number 0 in EBX
	int 0x80			; syscall 80 (Interrupt)

section .data:
	message: db "Hello World!", 0xA
	message_length equ $-message

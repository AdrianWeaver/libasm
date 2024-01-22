	;file:		ft_strcpy.s
	;output:	part of libasm.a
	;created:	05/01/2024
	;modified:	22/01/2024
	;author:	aweaver
	;version:	nasm 2.15.05	for x86-64
	;overview:
		;this is part of the project libasm from school 42
		;the purpose of this project is to learn asm x86-64 by coding
		;a library of functions
		;this is an implementation of strcpy from libc
		;this function is used to copy a string in another one
		;see man 3 strcpy

	section		.data
	section		.bss
	section		.text
	global		ft_strcpy

; char *strcpy(char *dest, char *src);
ft_strcpy:
	mov		rax, rdi		;storing the dest adress to return
_loop:
	mov		rcx, [rsi]		;buffering src char.
	mov		[rdi], rcx		;copying buffered char to dest
	cmp		byte [rsi], 0	;checking if end of string reached
	jz		_finish
	inc		rsi				;iterating on src string
	inc		rdi				;iterating on dest string
	jmp		_loop

_finish:
	ret

	;file:		ft_strcmp.s
	;output:	part of libasm.a
	;created:	05/01/2024
	;modified:	22/01/2024
	;author:	aweaver
	;version:	nasm 2.15.05	for x86-64
	;overview:
		;this is part of the project libasm from school 42
		;the purpose of this project is to learn asm x86-64 by coding
		;a library of functions
		;this is an implementation of strcmp from libc
		;this function is used to compare two strings
		;see man 3 strcmp

	section		.data
	section		.bss
	section 	.text
	global		ft_strcmp

; int ft_strcmp(char *s1, char *s2);
ft_strcmp:
	xor		rax, rax		;set return value to 0
	cmp		qword rsi, 0	;checking for NULL on first arg
	je		finish
	cmp		qword rdi, 0	;checking for NULL on second arg
	je		finish

_loop:
	mov		al, [rdi] 		;storing char from dest string in buffer
	sub		al, [rsi]		;comparing char from dest and src
	jnz		finish			;quitting loop if chars do not match
	cmp		byte [rsi], 0	;check if \0 reached
	je		finish			;quitting loop if end of source string reached
	inc		qword rsi		;iterating on src string
	inc		qword rdi		;iterating on dest string
	jmp		_loop

finish:
	movsx	eax, al			;adjusting the sign bit for an int
	ret


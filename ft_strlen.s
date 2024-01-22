	;file:		ft_strlen.s
	;output:	part of libasm.a
	;created:	08/01/2024
	;modified:	22/01/2024
	;author:	aweaver
	;version:	nasm 2.15.05	for x86-64
	;overview:
		;this is part of the project libasm from school 42
		;the purpose of this project is to learn asm x86-64 by coding
		;a library of functions
		;this is an naive implementation of strlen from libc
		;this function returns the size of a null terminated string
		;see man 3 strlen

	section		.data
	section		.bss
	section		.text
	global		ft_strlen;

;size_t	ft_strlen(char *str)
ft_strlen:
	mov		rax, rdi	;storing the base address

_loop:
	cmp		byte [rax], 0 ;checking for end of string
	je		_end
	inc		rax				;interating on string
	jmp		_loop
_end:
	sub		rax, rdi
	ret


	;a more complex implementation can be done following the libc one
	;the trick is to align the memory read so each time the memory value
	;is loaded into a register, it reads 8bytes (in 64)
	;then a magic trick is used to check if one of these bytes is a \0
	;the trick is to use two opposing magic bit patterns 0x80 and 0x10
	;then either iterate 8bytes further in the string if no \0 was found
	;or iterate in these 8bytes to find the culprit if it was found.
	;the return is always calculated at the end using an offset of address
	;so no additional instruction is done at each cycle, only the base addess
	;is stored
	;for time constraints I took the time to understand this and chose not to
	;code it, sometimes prioritizing is frustrating but is still the good
	;thing to do (:

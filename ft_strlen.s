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
		;this once was a naive implementation of strlen from libc
		;this is now the closest implementation I could do for libc strlen
		;though it is only a 64bits version.
		;this function returns the size of a null terminated string
		;see man 3 strlen

	section		.data
	section		.bss
	section		.text
	global		ft_strlen;

;size_t	ft_strlen(char *str)
ft_strlen:
	mov		rax, rdi	;storing the base address

;the purpose of this loop is to align the memory on an address ending
;by three zeros. Basically aligned on 8 bytes.
_loop_align:
	mov		rcx, 07h		;preparing a mask on the last 3 bits
	and		rcx, rax		;check last three bits of address
	cmp		rcx, 0			;if last three bits are 0, address is aligned
	je		_magic			;if address is aligned in memory do some magic
	cmp		byte [rax], 0 	;else check for \0
	je		_end			;if \0 found return
	inc		rax				;interating on string one byte by one byte
	jmp		_loop_align

;this part is to me the trickiest part.
;it's not really clean, it could be better to suit 32bits/64 bits.
;right now it only works for 64bits systems
;the libc does it better but... time constraints

_magic:
	mov		r8, 0101010101010101H	;set lomagic
	mov		r9, 08080808080808080H	;set himagic

;looping 8 bytes at a time
;checking if in these 8bytes one of them is a \0 (all bits unset)
;looking for 8 bytes at a time using a magic bit pattern mask

_magic_loop:
	mov		rcx, qword [rax]	;get 'longword' of 8 bytes
	mov		rdx, rcx			;get a copy of 'longword'
	sub		rcx, r8				;substract the lomagic 64bytes version
	not		rdx					;invert all bits of longword
	and		rcx, rdx			;mask previous value with ~longword
	and		rcx, r9				;mask himagic
	cmp		rcx, 0				;if this calcul is zero loop
	jne		_loop
	inc		qword rax			;iterating 8 bytes at a time
	jmp 	_magic_loop


;if in 8 bytes, one has all bits set to 0
;iterate one byte at a time to find the culprit
_loop:
	cmp		byte [rax], 0 	;checking for end of string
	je		_end
	inc		rax				;interating on string
	jmp		_loop

_end:
	sub		rax, rdi
	ret


	;this is a complex implementation of strlen following the libc one
	;the trick is to align the memory read so each time the memory value
	;is loaded into a register, it reads 8bytes (in 64)
	;then a magic trick is used to check if one of these bytes is a \0
	;the trick is to use two opposing magic bit patterns 0x80 and 0x10
	;then either iterate 8bytes further in the string if no \0 was found
	;or iterate in these 8bytes to find the culprit if it was found.
	;the return is always calculated at the end using an offset of address
	;so no additional instruction is done at each cycle, only the base addess
	;is stored
	;for time constraints I took the time to understand this and chose to
	;code a 64bits version only
	;sometimes prioritizing is frustrating but is still the good thing to do
	;many thanks to rertzer, sgaubert, bsavinel, afaure and my mate moor


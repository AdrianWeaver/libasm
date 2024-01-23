	;file:		ft_list_sort.s
	;output:	part of libasm.a
	;created:	18/01/2024
	;modified:	22/01/2024
	;author:	aweaver
	;version:	nasm 2.15.05	for x86-64
	;overview:
		;this is part of the project libasm from school 42
		;the purpose of this project is to learn asm x86-64 by coding
		;a library of functions
		;this function is used to sort a list, based on a comparison function
		;the sorting algorithm is extremely naive and simple, some kind of bubble sort
		;the type of the list is as such
		;8bytes - address of the data
		;8bytes - address of the next node

	section	.data
		ListNextOffset: equ 8
	section	.bss
	section	.text

	global	ft_list_sort

;void ft_list_sort(t_list **begin_list, int (*cmp)())
	;(*cmp)(list_ptr->data, data_ref)
ft_list_sort:
	cmp		rdi, 0			;checking for NULL list
	je		_error
	cmp		qword [rdi], 0	;checking for NULL first node
	je		_error
	cmp		rsi, 0			;checking for NULL as evaluation function
	je		_error
	enter	64, 0
	mov		[rsp + 8], rbx		;rbx - head of list (begin_list)
	mov		[rsp + 16], r12		;r12 - previous node->next pointer outer node
	mov		[rsp + 32], r13		;r13 - previous node->next pointer inner node
	mov		[rsp + 40], r14		;r14 - current outer node
	mov		[rsp + 48], r15		;r15 - current inner node
	mov		[rsp + 56], rsi		;saving comp function on stack	
	mov		rbx, rdi			;saving the pointer storing the end of list
	mov		r14, [rdi]			;saving current node
	mov		r12, rbx			;previous outer node is HEAD for first loop
	mov		rax, r14			;get address of next first pointer
	add		rax, 8					;--
	mov		r13, rax			;previous inner node is first node for first loop

_outer_loop:
	cmp		r14, 0				;if reached end of loop return, list is sorted
	je		_end
	cmp		qword [r14 + ListNextOffset], 0		;if next is 0 list is sorted
	je		_end
	mov		r15, [r14 + ListNextOffset]		;setting inner-loop-current
	mov		rax, r14			;address calcul prep
	add		rax, 8				;adding 8 to current to get address of pointer on next
	mov		r13, rax			;setting prev pointer for inner-loop

_inner_loop:
	mov		rdi, [r14]			;set current-outer data as arg1 of cmp
	mov		rsi, [r15]			;set current-inner data as arg2 of cmp
	call	[rsp + 56]			;call cmp
	cmp		rax, 0				;check return of function
	je		_swap				;if cmp returned 0 jmp to swap
	cmp		qword [r15 + ListNextOffset], 0		;check next of inner-loop
	je		_outer_loop_inc		;if next is NULL go back to outer loop	

_inner_loop_inc:
	mov		rax, r15
	add		rax, 8
	mov		r13, rax			;set current as new previous for inner loop
	mov		r15, [r15 + ListNextOffset]		;inner-current = next;
	jmp		_inner_loop			;loop on _inner_loop inconditionnaly

_outer_loop_inc:
	mov		rax, r14
	add		rax, ListNextOffset
	mov		r12, rax			;set prev-outer as current outer
	mov		r14, [r14 + ListNextOffset]		;go to next in outer loop
	jmp		_outer_loop

_swap:
	cmp		[rbx], r14			;check if outer-current is first of list
	je		_swap_head			;special case handler for head of list

_swap_resume:
	cmp		[r14 + ListNextOffset], r15		;check if the two nodes are next to each-other
	je		_swap_close
	jmp		_swap_far			;normal case

;in case the first link of the list is one of the two link that are swapped
;the value of the **begin_list pointer needs to be changed and needs a special case
_swap_head:
	mov		r12, rbx			;put in outer-previous the pointer on head		
	jmp		_swap_resume


;Two swap conditions, if the two nodes are next to each others or not
	;_swap close goes as follow case is A->next = B
		;A->next becomes B->next
		;B->next becomes A
		;prev->A becomes B
_swap_close:
	mov		rcx, [r15 + ListNextOffset]		;store inner->next
	mov		[r14 + ListNextOffset], rcx		;set outer->next to inner->next
	mov		[r15 + ListNextOffset], r14		;set inner->next to outer
	mov		[r12], r15			;set prev->outer->next to inner
								;no need to set prev->inner as it was actually outer
	mov		r14, r15			;inner becomes new outer before a new loop begins
	jmp		_inner_loop_inc

;Other swap condition, the two nodes are not next to each other
;A and C need to swap with B in the middle
	;_swap_far goes as follow case is A->next != C
			;store C->next (D or NULL)
			;C->next becomes A->next (B)
			;prev->A becomes C
			;prev->C->next (B->next) becomes A
			;A->next becomes stored B->next
_swap_far:
	mov		rcx, [r15 + ListNextOffset]		;store inner->next
	mov		rax, [r14 + ListNextOffset]		;store outer->next
	mov		[r15 + ListNextOffset], rax		;set inner->next to outer->next
	mov		[r12], r15			;set prev-outer->next to inner
	mov		[r13], r14			;set prev-inner->next to outer
	mov		[r14 + ListNextOffset], rcx		;set A->next to B->next
	mov		r14, r15			;inner becomes new outer
	jmp		_inner_loop_inc

_end:
	mov		rbx, [rsp + 8]		;restoring rbx
	mov		r12, [rsp + 16]		;restoring r12
	mov		r13, [rsp + 32]		;restoring r13
	mov		r14, [rsp + 40]		;restoring r14
	mov		r15, [rsp + 48]		;restoring r15
	leave
	ret

_error:
	ret


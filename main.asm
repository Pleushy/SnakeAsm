;Snake in x86 assembly for linux
;Assembled with NASM 64-bit
;Written by Ari (@Pleushy)
;hi!


section .data
	scoreText db "Score: "
	scoreTextLen equ $-scoreText
	timeText db "Time: "
	timeTextLen equ $-timeText
	border db "#"
	snakePart db "*"
	apple db "O"
	empty db "."
	endl db 10
	startSize db 1
	arenaSizeY db 20
	arenaSizeX db 40
	updateDelay dq 0, 100000000 ; 1 milisecond

section .bss
	scorePlaced resb 1
	timePlaced resb 1
	size resb 1
	score resb 2
	time resb 2

section .text
	global _start

_start:
	call _drawArena

	mov rax,60
	xor rdi,rdi
	syscall

_drawArena:
	movzx rcx, byte [arenaSizeY]
	add rcx,7 ;border offset + room for stats
	mov r8,rcx

	.loop1:
	push rcx

	movzx rcx, byte [arenaSizeX]
	add rcx,2 ;border offset
	mov r10,rcx

	.loop2:
	pop rax
	cmp rax,1
	je .border
	cmp rax,r8
	je .border
	mov r9,r8
	sub r9,5
	cmp rax,r9
	je .border
	cmp rcx,1
	je .border
	cmp rcx,r10
	je .border

	add r9,2
	cmp rax,r9
	je .placeScore
	add r9,1
	cmp rax,r9
	je .placeTime
	jmp .empty

	.empty: ; TODO
	mov rsi,empty
	mov rdx,1
	call _print
	jmp .c

	.placeScore: ; TODO
	cmp byte [scorePlaced],1
	je .c
	mov byte [scorePlaced],1
	mov rsi,scoreText
	mov rdx,scoreTextLen
	call _print
	mov rsi,score
	mov rdx,2
	call _print
	jmp .c

	.placeTime: ; TODO
	cmp byte [timePlaced],1
	je .c
	mov byte [timePlaced],1
	mov rsi,timeText
	mov rdx,timeTextLen
	call _print
	mov rsi,time
	mov rdx,2
	call _print
	jmp .c

	.border:
	mov rsi,border
	mov rdx,1
	call _print

	.c:
	push rax
	dec rcx
	jnz .loop2

	pop rcx

	mov rsi,endl
	mov rdx,1
	call _print

	dec rcx
	jnz .loop1

	mov byte [scorePlaced],0
	mov byte [timePlaced],0
	ret

_print: ; rsi = string, rdx = len
	push rax
	push rcx
	mov rax,1
	xor rdi,rdi
	syscall
	pop rcx
	pop rax
	ret

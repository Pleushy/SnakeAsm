// Snake in x86 assembly for linux //
// Assembled with NASM 64-bit //
// Written by Ari (@Pleushy) //
// hi! //

section .data
	border db "#"
	snakePart db "*"
	apple db "O"
	empty db "."
	endl db 10
	startSize db 1
	arenaSize db 8
	updateDelay dq 0, 100000000 // 1 milisecond

section .bss
	size resb 1
	score resb 2
	time resb 2

section .text
	global _start

_start:
	//todo

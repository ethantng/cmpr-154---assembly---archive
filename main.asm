;------------------------------------------------------------
; masm.asm add two integers
; Ahmed Alweheiby
; CMPR - 154 - Fall 2023
; March 22, 2023
; Collaboration : None
;----------------------------------------------------------
INCLUDE Irvine32.inc
.386

.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode : dword
.data

sum DWORD 0

.code
main proc

	mov eax, 50
	add eax, 30
	mov sum, eax
	invoke ExitProcess, 0

main endp
end main
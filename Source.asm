combineStrings: 
	; [INPUT] : RCX=string1, RDX=string2, R8=outputBuffer
	; [OUTPUT]: R8=filledBuffer
	mov R15, rcx
	mov R14, R8
	.loop1:
		cmp [R15], byte 0
		je .le1
		mov AL, byte[R15]
		mov [R8], AL
		inc R15
		inc R8
		jmp .loop1
	.le1:
	mov R15, rdx
	.loop2:
		cmp [R15], byte 0
		je .le2
		mov AL, byte[R15]
		mov [R8], AL
		inc R15
		inc R8
		jmp .loop2
	.le2:
	ret
compareStrings:
	; [INPUT] : RCX=string1, RDX=string2
	; [OUTPUT]: AL=True(0xFF)/False(0x00)
	mov R15, RCX
	mov R14, RDX
	.loop:
		mov BL, byte [R15]
		cmp BL, byte [R14]
		jne .leNe
		mov AL, 0xFF
		cmp [R15], byte 0
		je .leE
		cmp [R14], byte 0
		je .leE
		inc R15
		inc R14
		jmp .loop
	.leNe:
		mov AL, 0x00
	.leE:
	ret
clearBuffer:
	; [INPUT] : RCX=buffer, RDX=bufferLength
	; [OUTPUT]: RCX=clearedBuffer
	mov [RCX+RDX], byte 0
	dec RDX
	cmp RDX, 0
	jne clearBuffer
	ret
skipSubstring:
	;[INPUT] : RCX=buffer, RDX=string, R8=startIndex
	;[OUTPUT]: RCX=filledBuffer
	mov R15, rdx
	add R15, R8
	mov R14, rcx
	.loop:
		cmp [R15], byte 0
		je .le
		mov AL, byte[R15]
		mov [R14], AL
		inc R15
		inc R14
		jmp .loop
	.le:
	ret
substringUntil:
	;[INPUT] : RCX=buffer, RDX=string, R8=length
	;[OUTPUT]: RCX=filledBuffer
	mov R15, rdx
	mov R14, rcx
	.loop:
		cmp R8, byte 0
		je .le
		mov AL, byte[R15]
		mov [R14], AL
		inc R15
		inc R14
		dec R8
		jmp .loop
	.le:
	ret
skipString:
	;[INPUT] : RCX=buffer, RDX=strings, R8=startIndex
	;[OUTPUT]: RCX=filledBuffer
	mov R15, rdx
	mov R13, R8
	.lp1:
		.lp2:
			cmp [R15], byte 0
			je .le2
			inc R15
			jmp .lp2
		.le2:
		inc R15
		dec R13
		cmp R13, 0
		jne .lp1
	mov R14, rcx
	.loop:
		cmp [R15], byte 0
		je .le
		mov AL, byte[R15]
		mov [R14], AL
		inc R15
		inc R14
		jmp .loop
	.le:
	ret

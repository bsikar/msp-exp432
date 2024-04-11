		area war_of_words, code, readonly
		export __main
__main	proc
	
		mov r7, #0
		mov r0, #18
		
L1		cmp r0, #3
		blt O1
		mov r1, #16
		
L2		cmp r1, #40
		bge O2
		mov r2, #0
		
L3		cmp r2, #30
		bge O3
		add r2, #1
		add r7, #1	; inc r7
		b	L3

O3		add r1, #1
		b L2
O2		sub r0, #1
		b L1
O1

		endp				
		end
				
			
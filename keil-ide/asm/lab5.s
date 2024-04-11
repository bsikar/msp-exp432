		area Lab5, code, readonly
		export __main

__main 	proc
		ldr r0, =0x40004c00		; gpio base
		add r0, #0x21			; p4 offset
		mov r1, #0xf0			; byte 1111 0000
		strb r1, [r0, #0x04]	; registers pins 4.4, 4.5, 4.6, 4.7 as outputs
		
loop	ldr r2, [r0, #0x00]		; loads all pins into r2
		add r2, #0x0f			; masks to only input pins
		lsl	r2, #4				; Shift input bits to output positions
		mvn	r3,	r2				; flip the bits
		strb r3, [r0, #0x02]	; store into p4
		b loop					; loop
		
		endp
		end
		
/*
__main	proc
		ldr r0, =0x40004c00
		add r0, #0x21
		mov r1, #0xF0
		strb r1, [r0, #0x04]
			
repeat
		mov r5, #0x00
		ldrb r3, [r0]
			
check0 	and r4, r3 , #0x01
		cmp r4, #0x01
		beq check1
		orr r5, #0x10
			
check1 	and r4, r3 , #0x02
		cmp r4, #0x02
		beq check2
		orr r5, #0x20
			
check2	and r4, r3 , #0x04
		cmp r4, #0x04
		beq check3
		orr r5, #0x40
			
check3 	and r4, r3 , #0x08
		cmp r4, #0x08
		beq store
		orr r5, #0x80
			
store 	strb r5 , [r0, #0x02]
		b repeat
			
		endp
			
		end
*/
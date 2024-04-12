			area Lab4, code, readonly
			export __main
__main		proc
	
			LDR R0, =0x40004C00
			ADD R0, #0x40
			mov R1, #0x03
			strb R1, [R0, #0x04]
			mov R1, #0x10
			strb R1, [R0, #0x06]
			strb R1, [R0, #0x02]
			
			
			;on for pin6.0
repeat		LDRB R2, [R0, #0x00]
			AND R2, #0x10
			cmp R2, #0x00
			;BEQ LED2
			mov R1, #0x01
			strb R1, [R0, #0x02]
			B Skip
			
LED2		mov R1, #0x02
			strb R1, [R0, #0x02]
			
Skip		B repeat
			
			endp
				
			end
				
			

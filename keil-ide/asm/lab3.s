; lab 3 toggle led

            area lab3, code, readonly
            export __main
__main      proc

            ; configure gpio
            ldr 	r0, =0x40004c00 	; port 1 base addr
            add 	r0, #0x41       	; port 6 base addr
            mov		r1, #0x31       	; byte to configure pins 5, 4, 0 as output
            strb 	r1, [r0, #0x04]    	; configure pins 6.5, 6.4, 6.0 as output

            ; loop and toggle leds
repeat        
			mov 	r1, #0x01      		; byte to make only pin 0 high
            strb 	r1, [r0, #0x02]		; make all pins high
            bl 		nested_d        	; remain on for a while

            mov 	r1, #0x00       	; byte to make pin 4 high
            strb 	r1, [r0, #0x02]    	; make all pins high
            bl 		nested_d        	; remain on for a while

            mov 	r1, #0x10       	; byte to make pin 5 high
            strb 	r1, [r0, #0x02]    	; make all pins high
            bl 		nested_d        	; remain on for a while

			mov 	r1, #0x00			; byte to make all pins low
			strb 	r1, [r0, #0x02]		; make all pins low
			bl 		nested_d

			mov 	r1, #0x20			; byte to make all pins low
			strb 	r1, [r0, #0x02]		; make all pins low
			bl 		nested_d
			
			mov 	r1, #0x00			; byte to make all pins low
			strb 	r1, [r0, #0x02]		; make all pins low
			bl 		nested_d

            b 		repeat          	; loop infinitely
            endp            			; end __main

delay       function        			; declare new procedure
            mov 	r12, #0xf000    	; note: turn this constant if needed
			
continue    sub 	r12, #0x01
            cmp 	r12, #0x00
            bne 	continue        	; continue until r12 is positive
            bx 		lr           		; return to address in lr
            endp            			; end procedure of delay
 
nested_d	function
			mov 	r2, #100			; set outer loop cnt
			
outer_l		mov		r3, #1000			; set inner loop cnt

inner_l		subs	r3, r3, #1
			bne		inner_l
			
			subs	r2, r2, #1
			bne		outer_l
			
			bx		lr
			endp
			
			end


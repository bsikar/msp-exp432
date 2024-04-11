; lab 2
  area lab2, code, readonly
  export __main

word_data dcd 0x12345678, 0x2BCD1234, 0x1234ABCD, 0x4FAABBCC, 8
word_data_len equ 5

counter rn r12
current rn r3
array   rn r1
max_val rn r8
	
__main proc
			; task 4
			mov max_val, #0					; start the max value to be 0
			ldr array, =word_data			; load the array into memory
			mov counter, #0					; start the counter
more_to_go	ldr current, [array]			; load current value
			cmp current, max_val			; compare current and max
			blt skip						; current - max_val
											; and if n flag is set then the max_value 
											; is larger than current
			
			mov max_val, current			; if n flag isnt set then the max_value can
											; be updated
skip		add counter, #1					; increase the counter
			add array, #4					; increase the array pointer
			cmp counter, #word_data_len		; compare the count and the length
			bne more_to_go					; if they are equal z flag is set so end
			
			endp
			end

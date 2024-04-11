; lab 1
  area lab1, code, readonly
  export __main

__main proc           ; start of the procedure
  ldr r0, =0x20000008 ; load the literal address 0x20000008 into register r0
  ldr r1, =0xabcd1234 ; load the literal value 0xabcd1234 into register r1
  
  str r1, [r0]        ; store the value from register r1 into the memory 
                      ; address pointed by r0
  
  ldr r0, =0x20002007 ; load the literal address 0x20002007 into register r0
  add r1, r1, #0x1f   ; add the value 0x1f to the value of register r1 and 
                      ; store the result back in r1
  str r1, [r0]        ; store the value from register r1 into the memory
                      ; address pointed by r0
  
  add r1, r1, #0x2f   ; add the value 0x2f to the value of register r1 and 
                      ; store the result back in r1
  add r10, r0, #23    ; add the value 23 to the value of register r0 and store
                      ; the result in r10
  str r1, [r10]       ; store the value from register r1 into the memory
                      ; address pointed by r10
  
  ldr r5, [r10]       ; load into register r5 the value from the memory address
                      ; pointed by r10
  
  endp                ; end of the procedure
  end                 ; end of the program

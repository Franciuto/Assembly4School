; Francesco Fontanesi 16/01/2025
; https://github.com/Franciuto/AsmCalculator

.model SMALL
.stack 100h 
.data  
; Input
   result            dw     0
   dec_res           dw     0
   op1               dw     0
   op2               dw     0
   str_res           db     7, ?, 6 dup('$')       ; Variable to store the result as a printable string      
   op1_raw           db     6, ?, 5 dup('$')       ; Variable to store the first operand
   op2_raw           db     6, ?, 5 dup('$')       ; Variable to store the second operand (if present)
   op                db     2, ?, 1 dup('$')       ; Variable to store the selected operation
  
; Strings
   intro             db     'ASMCalculator$'       ; Program introduction
   docs              db     10, 13, 'See docs on GitHub at Franciuto/ASMCalculator$'  ; Documentation link
   operation_prt     db     10, 13, 10, 13, 'Insert operation: $' 
   op1_str           db     10, 13, 'Insert operand 1: $'       ; Prompt for operand 1
   op2_str           db     10, 13, 'Insert operand 2: $'       ; Prompt for operand 2
   res_str           db     10, 13, 10, 13, 'Result is: $'      ; Result message
   error             db     10, 13, 'ERROR!!$'                  ; Error message
   
.code 
; Load data segment
   mov ax , @data
   mov ds , ax 
   
; INTRODUCTION
   ; Print intro
      mov ah , 9h
      lea dx , intro
      int 21h 
   ; Print documentation link
      lea dx , docs
      int 21h                   
   
; SELECT OPERATION
   ask_type:
   ; Prompt for operation
      lea dx , operation_prt
      int 21h
   ; Input operation
      mov ah , 0ah
      lea dx , op
      int 21h
   ; Check operation type 
      lea si , op
      add si , 2
      cmp [si], 'a'            ; Addition
      je sum
      cmp [si], 's'            ; Subtraction
      je subtraction
      cmp [si], 'm'            ; Multiplication
      je multiplication
      cmp [si], 'd'            ; Division
      je divide
      cmp [si], 'e'            ; Power
      je power
      cmp [si], 'r'            ; Square root
      je square_root
      cmp [si], 'o'            ; Module - TO FIX
      je module
      cmp [si], 'n'
      ; Placeholder for sin
      cmp [si], 'c'
      ; Placeholder for cosin
      cmp [si], 't'
      ; Placeholder for tan
      mov ah, 9h
      lea dx, error
      int 21h
      jmp ask_type  

; CASE SUM
   sum:
   ; Ask input for operands
      call ask2_ops              ; Call the procedure to ask 2 operators
      mov bx , op1               ; Load the first operand into BX
      mov cx , op2               ; Load the second operand into CX
      add bx , cx                ; Perform addition
      mov dec_res , bx           ; Store the result in "dec_res"
      jmp op_done                ; Jump to op_done to display the result
      
; CASE SUBTRACTION
   subtraction:
   ; Ask input for operands
      call ask2_ops              ; Call the procedure to ask 2 operators
      mov bx , op1               ; Load the first operand into BX
      mov cx , op2               ; Load the second operand into CX
      sub bx , cx                ; Perform subtraction
      mov dec_res , bx           ; Store the result in "dec_res"
      jmp op_done                ; Jump to op_done to display the result  
      
; CASE MULTIPLICATION 
   multiplication:
   ; Ask input for operands
      call ask2_ops              ; Call the procedure to ask 2 operators
      mov bx , op1               ; Load the first operand into BX
      mov ax , op2               ; Load the second operand into AX for 16-bit multiplication
      mul bx                     ; Execute multiplication
      mov dec_res , ax           ; Store the result in "dec_res"
      jmp op_done                ; Jump to op_done to display the result

; CASE DIVISION
   divide:
      call ask2_ops              ; Call the procedure to ask 2 operators
      mov ax , op1               ; Load the first operand into AX
      mov cx , op2               ; Load the second operand into CX
      div cx                     ; Perform division
      mov dec_res , ax           ; Store the quotient in "dec_res
      jmp op_done                ; Jump to op_done to display the result                                               
           
; CASE POWER
   power:
      call ask2_ops              ; Call the procedure to ask 2 operators
      mov ax , op1               ; Load the base into AX
      mov cx , op2               ; Load the exponent into CX
      dec cx                     ; Decrease the exponent by 1
      mov bx , op1               ; Copy the base into BX
      mult_loop:                 ; Loop to calculate power
         mul bx                  ; Multiply AX by BX (base)
      loop mult_loop             ; Repeat until CX = 0
      mov dec_res , ax           ; Store the result in "dec_res"
      jmp op_done                ; Jump to op_done to display the result

; CASE SQUARE ROOT  
   square_root:
      call ask1_op               ; Ask for one operand
      mov ax , op1               ; Load the operand into AX
      mov cx , 1                 ; Initialize CX to 1 (for odd number subtraction)
      sqrt_loop:
         sub ax, cx              ; Subtract CX from AX
         jl sqrt_done            ; If AX < 0, exit loop    
         add cx, 2               ; Increment CX to the next odd number
         inc [dec_res]           ; Increment the square root result
      jmp sqrt_loop              ; Repeat the loop 
      
      sqrt_done:
         jmp op_done             ; Jump to op_done to display the result
      
; CASE MODULE - TO FIX
   module:
      call ask2_ops              ; Call the procedure to ask 2 operators
      mov ax , op1               ; Load the first operand into AX
      mov cx , op2               ; Load the second operand into CX
      div cx                     ; Perform division
      mov dec_res , dx           ; Store the remainder in "dec_res
      jmp op_done                ; Jump to op_done to display the result                                             

; OPERATION DONE
   op_done: 
      mov ax , dec_res           ; Load the number in AX
      lea si , str_res + 2       ; Load the address of the result ascii printable variable in si
      call int2str               ; Convert the result to a string

; PRINT RESULT
   ; Print result prompt
      mov ah , 9h
      lea dx , res_str
      int 21h
   ; Print the result value
      lea dx , str_res
      int 21h
      
; HALT THE EMULATOR      
      hlt                         

 
 
; PROCEDURES

; ASK INPUT for 2 operands
   ask2_ops proc
      ; Print prompt for operand 1
         mov ah , 9h
         lea dx , op1_str
         int 21h
      ; Get input for operand 1
         mov ah , 0ah
         lea dx , op1_raw
         int 21h
      ; Print prompt for operand 2
         mov ah , 9h
         lea dx , op2_str
         int 21h 
      ; Get input for operand 2
         mov ah , 0ah
         lea dx , op2_raw      
         int 21h
      ; Convert inputs to integers
         ; Operand 1
         lea si , op1_raw + 2                   ; Skip length and prefix
         call str2int                           ; Convert operand 1 to integer
         mov ax , result                        ; Store converted value in AX
         mov op1 , ax                           ; Move to "op1"
         ; Operand 2
         mov result , 0                         ; Reset result variable
         lea si , op2_raw + 2                   ; Skip length and prefix
         call str2int                           ; Convert operand 2 to integer
         mov ax , result                        ; Store converted value in AX
         mov op2 , ax                           ; Move to "op2"
         ret
   ask2_ops endp      

; ASK INPUT for 1 operand
   ask1_op proc
      ; Print prompt for operand 1                         
         mov ah , 9h
         lea dx , op1_str
         int 21h
      ; Get input for operand 1
         mov ah , 0ah
         lea dx , op1_raw
         int 21h
      ; Convert input to integer
         lea si , op1_raw + 2                   ; Skip length and prefix
         call str2int                           ; Convert to integer
         mov ax , result                        ; Store converted value in AX
         mov op1 , ax                           ; Move to "op1"
      ret
  ask1_op endp   
           
; Convert a string representation of a number (address in SI register) 
; into an unsigned 16-bit decimal number (range: 0 to 65535).
   str2int proc
      mov bx , 10                               ; Load the base 10 divider 
      
      convert_loop:                             ; Loop to convert each digit
         xor ah , ah                            ; Clear AH for division
         mov al , [si]                          ; Load the current character
         cmp al , 0dh                           ; Check for newline (end of input)
         je done                                ; Exit if newline is encountered
         
         sub al, '0'                            ; Convert ASCII to numerical value
         mov cx, ax                             ; Store current digit in CX
         mov ax, result                         ; Load the accumulated result
         mul bx                                 ; Multiply result by 10
         add ax, cx                             ; Add the current digit
         mov result, ax                         ; Store the updated result
               
         inc si                                 ; Move to the next character
         jmp convert_loop                       ; Repeat conversion
           
      done:                                     ; Conversion complete
         ret  
   str2int endp
   
   
; Procedure that converts the decimal number given in the AX register and saves it to the address of the variable at the SI register
int2str proc
   mov bx , 10                                  ; Load base 10
   xor cx , cx                                  ; Clear CX for loop counter
   xor dx , dx
  
   division:
      div bx                                    ; Divide AX by 10
      push dx                                   ; Push the remainder onto the stack
      xor dx , dx                               ; Clear DX
      inc cx                                    ; Increment the loop counter
      or ax , ax                                ; Check if division is complete
      jnz division                              ; Repeat if not
  
   string_composer:                             
      pop dx                                    ; Get remainder from stack
      add dl , '0'                              ; Convert to ASCII
      mov [si] , dl                             ; Store character in output buffer
      inc si                                    ; Move to next position
   loop string_composer                         ; Process all digits
   ret   
int2str endp

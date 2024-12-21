; Francesco Fontanesi 05/12/2024
; "Despaghettification"

org 100h

jmp start      
    
vec dw 45,97,213, 251, 39, 56, 178, 210, 0,127   
       
res dw 0    
     
start: 
    xor dx,dx
    lea bx, vec
    ;mov bx, offset vec
    mov cx, 10
    
sloop:
    mov ax,[bx]
    and ax, 0000000000000100b
    jz fine
    mov dx,[bx]
    add res, dx 
    inc bx  
    loop sloop   
        
fine:   
    
ret





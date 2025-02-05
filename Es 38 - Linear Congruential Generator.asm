; Francesco Fontanesi XX/XX/XX
; Generatore numeri random

.model SMALL
.stack 100h
.data
seed dw 0
.code
main proc
; Caricamento data segment
   mov ax , @data
   mov ds , ax
   
   call randomGen
      
rand proc
    ; Aggiorno il seed
        call sRand
    ; (25173 * seed + 13849) 
        mov ax , seed
        mov bx , 25173
        mul ax
        add ax , 13849
    ; Modulo 32768
        
    
    
    
; Inizializza il timer con il clock since midnight del processore
sRand proc
    ; SEED
        xor ax , ax
        int 1ah
        mov seed , dx
    ret
sRand endp

end main
ret 
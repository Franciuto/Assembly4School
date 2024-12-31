; Francesco Fontanesi 31/12/2024
; Creazione calcolatrice che accetta operandi mono-cifra interi e restituisce il risultato

data segment 
   error db 'ERROR!!$'                                             
   intro db 'Calcolatrice Assembly$'
   prompt db 'Inserire operazione, operando1 e operando2: $'
   acapo db 10, 13, '$'
   input db 4
   ends

stack segment

ends

code segment
start: 
    mov ax, data
    mov ds, ax
    mov es, ax
    
    ; Stampa introduzione
    mov ah , 9h
    lea dx , intro 
    int 21h
    ; New Line
    lea dx , acapo
    int 21h
    ; Stampa prompt
    lea dx , prompt
    int 21h
    
    ; Richiesta input
    mov ah , 0ah
    lea dx , input
    int 21h
    
    ; New Line
    mov ah , 9h
    lea dx , acapo
    int 21h
 
    ; Caricamento in registri
    lea si , input + 3
    mov bh , [si]           ; Op 1 in bh
    inc si
    mov bl , [si]           ; Op 2 in bl
    ; Conversione da ascii
    sub bh , '0'
    sub bl , '0' 
     
    ; Controllo operazione da svolgere
    lea si , input + 2
    cmp [si] , '+'          ; Controllo con il '+'
    jz op_add
    cmp [si] , '-'          ; Controllo con il '-'  
    jz op_sub
    cmp [si] , 'x'          ; Controllo con il 'x'
    jz op_mul
    cmp [si] , ':'          ; Controllo con il ':'         
    jz op_div                                        
    
    ; Se nessuna operazione è riconosciuta il programma da errore
    ; Stampa errore
    lea dx , error
    int 21h
    jmp fine
    
    ; Calcolo
    op_add:
        add bh , bl         ; Faccio una comune somma passando gli operandi
        mov al , bh         ; Sposto il risultato in al (come in tutte le operazioni)
        jmp next
        
    op_sub:
        sub bh , bl         ; Faccio una comune sottrazione passando gli operandi
        mov al , bh         ; Sposto il risultato in al (come in tutte le operazioni)
        jmp next       
    op_mul: 
        mov al , bh         ; Carico in al il primo operando
        mul bl              ; Moltiplico , Il valore è già in al quindi non sposto niente
        jmp next
        
    op_div:
        cmp bl , '0'
        xor ch , ch         ; Pulisco ch
        xor dx , dx         ; Pulisco tutto dx
        mov al , bh         ; Sposto l'operando
        xor ah , ah         ; Pulisco ah
        xor bh , bh         ; Pulisco bh
        div bx              ; Divido , Il valore è già in al quindi non sposto niente
        jmp next
    next: 
        xor ah , ah         ; Pulisco ah
        mov bl , 10         ; Sposto in bl il divisore
        div bl              ; Divido per isolare le decine dalle unità
        add al , '0'        ; Conversione in ascii
        add ah , '0'        ; Conversione in ascii     
        
        ; Stampa dei valori 
        mov bh , ah
        mov dl , al
        mov ah , 02h        
        int 21h
        mov dl , bh
        int 21h      
fine:   
ends

end start                                                 
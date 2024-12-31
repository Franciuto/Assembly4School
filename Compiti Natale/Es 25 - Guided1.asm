; Francesco Fontanesi 30/12/2024
; Data una stringa inserita contenente due cifre convertirla in un numero unsigned di due cifre

data segment  
   prompt db 'Inserisci numero in formato stringa: $'
   input db 3 ; Faccio una variabile di grandezza 3 byte per contenere il byte stesso '3' che indica la larghezza + 2 
              ; per contenere l'input effettivo
ends

stack segment

ends

code segment
start:
    ; Assignments
    mov ax, data
    mov ds, ax
    mov es, ax
    
    ; Scrive la stringa per cheiere il prompt
    mov ah , 09h
    lea dx , prompt
    int 21h
    
    ; Chiedo in input la stringa e la salvo nella variabile "input"
    mov ah , 0ah
    lea dx , input 
    int 21h
    
    ; Conversione prima cifra
    lea si , input + 2           ; Carico in si l'offset della variabile input + 2 per avere l'effettiva cifra
    mov al , [si]                ; Carico il valore in al
    sub al , '0'                 ; Conversione da ascii a intero
    xor ah , ah                  ; Azzero 'ah'
    mov bl , 10                  ; Carico come moltiplicatore il posto delle decine
    mul bl                       ; Moltiplico     
    
    ; Conversione seconda cifra
    inc si                       ; Incremento si per passare alla cifra 2
    mov dl , [si]                ; Sposto il valore in dl
    sub dl , '0'                 ; Converto da ascii a intero
    add al , dl                  ; Aggiungo alla decina l'unità ricavata ottenendo così il valore numerico in   
ends

end start
ret

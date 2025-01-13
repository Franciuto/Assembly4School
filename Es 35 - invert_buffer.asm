; Francesco Fontanesi 13/01/2025
; Data una stringa in input viene stampata invertita

.model SMALL
.stack 100h
.data
   str db 99, ?, 100 dup('$')
   prompt db 'Inserisci stringa da reversare: $'
   prompt2 db 10, 13, 'Stringa reversata: $'

.code
main proc
; Caricamento data segment
   mov ax , @data
   mov ds , ax
   
; Scrittura prompt
   mov ah , 9h
   lea dx , prompt
   int 21h
   
; Richiesta input
   mov ah , 0ah
   lea dx , str
   int 21h

; Scrittura prompt inversione
   mov ah , 9h
   lea dx , prompt2
   int 21h 
 
; Inversione
   ; Ciclo setup SI
   lea si , str                ; Carico offset variabile
   inc si                      ; Vado all'indirizzo dove si trova il numero di caratteri della variabile
   mov bl , [si]               ; Sposto in bl il numero di caratteri presenti
   xor bh , bh                 ; Pulisco bh per usare il registro a 16 bit
   add si , bx                 ; Aggiungo il numero all'indirizzo per andare alla fine del buffer
   mov cl , bl                 ; Sposto in cl per il ciclo 
   xor ch , ch                 ; Pulisco ch

   ; Ciclo per stampare al contrario
   mov ah , 2h                 
   print_reverse:
      mov dl , [si]            ; Carico la lettera  
      int 21h                  
      dec si                   ; Vado alla lettera precedente      
   loop print_reverse
      
   
end main
ret 

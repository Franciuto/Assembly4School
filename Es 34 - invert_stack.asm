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
   
; Inizializzo il ciclo usando il numero di caratteri presenti in variabile (estratto dalla variabile stessa)
   lea si , str
   inc si                     ; Salto al byte del numero di caratteri presenti
   mov cl , si                ; Sposto il numero di caratteri presenti in cl per fare un ciclo
   xor ch , ch                ; Pulisco ch
   inc si                     ; Si punta al primo carattere
; Caricamento in stack
   push_caratteri:
      xor bh , bh             ; Pulisco la parte alta di bx per usare il registro a 16 bit compatibile con lo stack
      mov bl , [si]           ; Sposto nella parte bassa la lettere
      push bx                 ; Carico nello stack
      inc si                  ; Passo al carattere successivo
   loop push_caratteri     
   
; Stampa prompt
   mov ah , 9h
   lea dx , prompt2
   int 21h
   
; Stampa stringa invertita
   mov ah , 2h
   ; Setup ciclo
   lea si , str
   inc si                     ; Salto al byte del numero di caratteri presenti         
   mov cl , si                ; Sposto il numero di caratteri presenti in cl per fare un ciclo
   xor ch , ch                ; Pulisco ch
   
   ; Stampa
   print_carartteri:
      pop dx                  ; Prelevo dallo stack e salvo in dx
      int 21h                 ; Essendo dx il registro per la stampa usando il codice funzione 2h sono pronto per la stampa con int 21h 
   loop print_carartteri
    
end main
ret 

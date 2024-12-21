; Francesco Fontanesi 02/12/2024
; Usiamo un registro 16 bit per codificare lo stato di un personaggio di un gioco

; Bit 02 (3 bit): Scudo (07)
; Bit 36 (4 bit): HP (015)
; Bit 7 (1 bit): Stato "ghost"
; Bit 8 (1 bit): Stato "invisibile"
; Bit 911 (3 bit): Tipo di arma (07)
; Bit 12 (1 bit): Ha la chiave
; Bit 1315 (3 bit): Direzione corrente (07)
; Implementa un programma che dato una word (hard-coded nel listato), stampa lo stato del personaggio.

newline MACRO
    ; Macro per stampare una nuova linea
    mov dl, 10           ; Newline
    int 21h              
    mov dl, 13           ; Carriage return
    int 21h             
ENDM

; Registro utilizzato per il salvataggio dati: CX

org 0100h                
mov ah, 2               

; Setup stato personaggio
mov cx, 0xB12B          ;  1011000100101011

; Scudo giocatore
mov bh, ch              
shr bh, 5                ; Sposta a destra di 5 per isolare i bit dello scudo
or bh, 00110000b         ; Converte il valore numerico in ASCII
mov dl, 'S'              ; Carattere di prefisso "S" per scudo
int 21h                  
mov dl, bh               ; Stampa il valore dello scudo
int 21h
newline                  

; HP Giocatore 
mov bh, ch               
shr bh, 1                ; Sposta a destra di 1 per escludere il bit Ghost
and bh, 00001111b        ; Isola i 4 bit degli HP
mov dl, 'H'              ; Carattere di prefisso "H" per HP
int 21h                  
cmp bh, 10               ; Controlla se HP >= 10
jl lower                 ; Se HP < 10, salta alla stampa diretta

mov al, 1                ; Imposta AL a 1 per rappresentare le decine (HP >= 10)
sub bh, 10               ; Sottrae 10 per calcolare le unità
or al, 00110000b         ; Converte le decine in ASCII
mov dl, al               ; Stampa le decine
int 21h

lower:
or bh, 00110000b         ; Converte le unità in ASCII
mov dl, bh               ; Stampa il valore delle unità o il valore diretto (HP < 10)
int 21h
newline                 

; Ghost
mov bh, ch               
and bh, 00000001h        ; Isola il bit Ghost
cmp bh, 1                ; Confronta se Ghost è attivo (1)
mov dl, 'G'              ; Carattere di prefisso "G" per Ghost
int 21h                  
je True_Ghost            ; Salta a True_Ghost se Ghost è attivo
mov dl, 'n'              ; Stampa "n" se Ghost non è attivo
jmp Continue

True_Ghost:
mov dl, 's'              ; Stampa "s" se Ghost è attivo

Continue:
int 21h
newline                

; Invisibilità
mov bh, cl               
shr bh, 7                ; Sposta a destra di 7 per isolare il bit Invisibilità
mov dl, 'I'              ; Carattere di prefisso "I" per Invisibilità
int 21h                  
cmp bh, 1                ; Confronta se Invisibilità è attiva
je True_Inv              ; Salta a True_Inv se Invisibilità è attiva
mov dl, 'n'              ; Stampa "n" se Invisibilità non è attiva 
jmp next

True_Inv:
mov dl, 's'              ; Stampa "s" se Invisibilità è attiva

next:
int 21h
newline                  

; Arma
mov bh, cl              
shr bh, 4                ; Sposta a destra di 4 per isolare i bit dell'arma
and bh, 00000111b        ; Maschera per ottenere i 3 bit dell'arma
or bh, 00110000b         ; Converte il valore numerico in ASCII
mov dl, 'A'              ; Carattere di prefisso "A" per Arma
int 21h                  
mov dl, bh              
int 21h
newline                  ; Stampa una nuova linea

; Chiave
mov bh, cl               
shr bh, 3                ; Sposta a destra di 3 per isolare il bit Chiave
and bh, 00000001b        ; Maschera per ottenere il valore booleano della Chiave
mov dl, 'C'              ; Carattere di prefisso "C" per Chiave
int 21h                 
cmp bh, 1                ; Controlla se possiede la chiave
je True_Key              ; Salta a True_Key se ha la chiave
mov dl, 'n'              ; Stampa "n" se non ha la chiave
jmp go_on

True_Key:
mov dl, 's'              ; Stampa "s" se ha la chiave

go_on:
int 21h
newline

; Direzione
mov bh , cl				
and bh , 00000111b		; Maschera per isolare i bit della posizione
or bh , 00110000b		; Conversione in ASCII
mov dl , 'D'			;Prefisso "D" per Direzione
int 21h		
mov dl , bh					
int 21h   



ret

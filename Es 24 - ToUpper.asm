; Francesco Fontanesi
; Richiedere l'immissione di una stringa con caratteri qualsiasi; a capo, stampare la stringa in caratteri maiuscoli.

newline MACRO
    ;New Line
    mov ah , 2
    mov dl , 10
    int 21h 
    mov dl , 13 
    int 21h 
ENDM

org 100h

jmp start
; Dichiarazione Variabiili
msg db "Inserisci una Stringa: $"
buffer db 100 dup ('$') 
to_print db 100 dup ('$')

start:
lea dx, msg             ; Carico l'inidizzo della variabile
mov ah, 9               ; Imposto AH su 9 per la funzione di print string
int 21h                 

lea dx , buffer         ; Carico l'indirizzo del buffer per l'input
mov ah, 0ah             ; Imposto AH su 0ah per il read string
int 21h

lea si , buffer + 2     ; Carico su si l'inizio della stringa + 2 per andare al primo valore valido    
lea di , to_print       ; Carico su di l'inizio della stringa per salvare l'output
 
upper:       
    mov bl , [si]       ; Carico valore su bl
    mov bh , [si + 1]   ; Carico su bh il valore successivo per saltare uno strano "0Dh" che viene caricato (??)
    cmp bh , '$'        ; Controllo se la stringa input è terminata
    je continue         
    and bl , 11011111b ; Mascheramento in uppercase
    mov dl , bl        ; Salvo l'output in una variabile
    mov [di] , bl
    inc si
    inc di
    jmp upper
        
    
continue: 
    newline
    mov ah , 9
    lea dx , to_print  ; Carico l'indirizzo
    int 21h
    

ret

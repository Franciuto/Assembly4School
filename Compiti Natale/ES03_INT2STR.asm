; Francesco Fontanesi 31/12/2024
; partendo dall�esempio2, estendere la logica del programma in modo che supporti numeri a 8bit 
; e stampi numeri fino a 255 (per i pi� ardimentosi numeri fino a 65535).

.model small
.stack 100h
.data
   num dw 65535      ; Valore massimo stampabile 65535 (16 bit)
   text db 'Stampa valore unsigned a cinque cifre (hard-coded)$'

.code
main proc
; Caricamento data segment
      mov ax , @data
      mov ds , ax
     
; Scrittura descrizione programma
    lea dx , text
    mov ah , 9h
    int 21h
    mov ah , 2h
    mov dl , 13
    int 21h
    mov dl , 10
    int 21h 
   
   xor dx , dx                      ; Pulizia registri
   xor cx , cx                      ; Pulizia registri
   mov bx , 10                      ; Divisore per dividere decine e unit�
   mov ax, num 
    
   divisione:
      div bx                        ; Divisione tra Ax e 10
      push dx                       ; Salvo il quoziente (cifra che mi interessa) sullo stack
      xor dx , dx                   ; Resetto per la prossima operazione
      inc cx                        ; Aumento cx per tenere conto di quante cifre sono state pushate
      or ax , ax                    ; Controllo se il quoziente � 0
      jz stampa                     ; Se � zero e quindi tutte le cifre sono state convertite vado alla stampa
      jmp divisione                 ; Altrimenti continuo a dividere 
      
   stampa:
      pop dx                        ; Prelevo dallo stack salvando in dx (risalgo lo stack)
      add dl , '0'                  ; Converto in ascii
      mov ah , 2h
      int 21h                       ; Stampo dl (la cifra)
      loop stampa                   ; Dato che cx contiene quante cifre sono state convertite finch� non � 0 (tutte sono stampate) continua 

end main
ret
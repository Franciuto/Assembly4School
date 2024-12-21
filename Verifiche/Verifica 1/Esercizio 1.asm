; Francesco Fontanesi
; Verifica Assembly 12/04/2024
; 3C INF  
; Fila 3

; CONSEGNA
; Esercizio 1
; Dato in input un numero qualsiasi tra 0 e 9 stampare il suo doppio  
; NOTA: Nota dato un qualsiasi numero intero, fare lo shift a sinistra di 1 bit equivale a moltiplicare per 2)    

org 0100h

; Richiesta input
mov ah , 1
int 21h

; Trasformazione in decimale
sub al , '0'

shl al , 1              ; Shift a sinistra per eseguire il doppio (Come indicato in consegna)
mov ah , 2              
add al , '0'            ;Trasformazione in codice ASCII
mov dl , al 
int 21h 
 
ret

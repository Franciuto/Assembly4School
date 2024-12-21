; Francesco Fontanesi
; Verifica Assembly 12/04/2024
; 3C INF  
; Fila 3

; CONSEGNA
; Esercizio 2
; Scrivi una sequenza di 10 numeri consecutivi in memoria. 
; Fai la somma di tutti quelli che hanno ad 1 il bit di peso 2. 
; Memorizza il risultato nella variabile RES a 16 bit.


org 0100h

mov si , 0200h      ; Uso "ES" come registro puntatore per l'accesso indiretto in memoria    

jmp start
RES dw 0

start:
; Attraverso l'accesso indiretto sposto 10 numeri "Hard coded" in memoria partendo dalla locazione 0200h
    mov [si] , 9h
    inc si
    mov [si] , 3h
    inc si
    mov [si] , 2h
    inc si
    mov [si] , 1h
    inc si
    mov [si] , 8h
    inc si
    mov [si] , 4h
    inc si
    mov [si] , 7h
    inc si     
    mov [si] , 3h
    inc si
    mov [si] , 4h
    inc si
    mov [si] , 6h
    inc si 
 
    mov si , 0200h      ; Imposto "si" a 0200h per andare ad eseguire la lettura da memoria           
    
    mov cl , 10         ; Setup del ciclo
           
    Confronto:
        mov bh , [si]
        mov bl , bh
        and bl , 00000010b  ; Escludo il secondo bit
        cmp bl , 00000010b  ; Confronto con il numero se avesse il secondo bit con peso 1
        je peso1            ; Se il peso del secondo bit   1 vado a "peso1"
        jmp fine
        peso1:              ; Aggiungo il valore originale alla somma    
            add dl , bh     
        fine:                   ; Passo al numero successivo incrementando il registro di indirizzo
            inc si   
            loop Confronto      ; Loop confronto (x10 perch  10 sono i valori inseriti)
    
; Faccio in modo di poter spostare il valore da registro a 8 bit a locazione 16bit
    xor bx , bx             ; Assicuro che bx sia vuoto
    mov bl , dl             ; Sposto nella parte bassa di bx dl
    lea si , RES            ; Metto in si l'indirizzo di inizio di variabile RES
    mov [si] , bx           ; Sposto in variabile RES il valore della somma
    
    ret

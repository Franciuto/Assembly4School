; Francesco Fontanesi
; Verifica Assembly 12/04/2024
; 3C INF  
; Fila 3

; CONSEGNA
; Esercizio 3
; Leggi una sequenza di caratteri da tastiera (terminata da INVIO), e forzala tutta in maiuscolo senza usare SOTTRAZIONI

org 0100h

; Setup Registri
mov ah , 1
mov di , 0200h

start:
    int 21h     
    mov [di] , al           ; Accesso in memoria per salvare la stringa in input
    inc di              
    cmp al , 13             ; Confronto il valore inserito con 13 (Carriage return) Valore dello spazio
    je continue             ; Se sono uguali continuo con la forzatura in uppercase
    jmp start               ; Se sono diversi ripeto il ciclo per far inserire il prossimo carattere
    
continue:               
    mov di , 0200h          ; Reset del puntatore indirizzi di memoria
    mov ah , 2
    force_uppercase:     
        cmp [di] , 13       ; Controllo se il carattere che si sta per forzare in uppercase è 13 (Ho salvato in memoria anche quest'ultimo come valore tappo)
        je exit             ; Nel caso tutta la stringa è stata forzata quindi posso uscire dal programma
        mov bh , [di]   
        and bh , 01011111b  ; Mascheramento per trasformare in maiuscolo
        mov dl , bh         
        int 21h  
        inc di
        jmp force_uppercase

exit:     
    ret





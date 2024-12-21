; Francesco Fontanesi     3C Inf
; Richiedere l'immisione di una stringa da tastiera. Codificare il testo immesso con ROT13
; badando a rimuovere gli spazi e punteggiature, trasformando tutto in minuscolo
; e senza alterare le cifre.

org 0100h
jmp start
prompt dw 'Inserisci stringa in chiaro: $'         ; Variabile per la scrittura stringa prompt
plain_text dw 100 dup('$')                   ; Variabile che contiene il raw input
to_encrypt dw 100 dup('$')                   ; Variabile che contiene il contenuto da criptare (solo numeri e lettere)
output dw 100 dup ('$')                      ; Variabile che contiene output criptato 
newline db 13, 10, '$'                       ; Variabile per creazione newline
                          
                          
start:
lea dx , prompt            ; Imposto dx come puntatore della variabile
mov ah , 9h                ; Imposto ah a 9 per la scrittura stringhe 
int 21h                    

mov ah , 0ah               ; Imposto ah a 0a per imput da stringa
lea dx , plain_text        ; Imposto dx come putatore della variabile
int 21h 

lea si , plain_text + 1    ; Imposto si come puntatore della variabile 
lea di , to_encrypt        ; Imposto si come puntatore della variabile

; Ciclo per rimuovere tutto quello che non è lettere o numeri
remove:
    inc si                 ; Scorrimento variabile
    inc di                 ; Scorrimento variabile    
    mov bl , [si]          ; Carico valore in bl
    cmp bl , '$'           ; Confronto con il valore $ di fine stringa
    je fine                ; Se uguale ho incontrato '$' e quindi fine della stringa da analizzare
    cmp bl , 'a'           ; Controllo con 'a'
    jae into_a             ; Se maggiore uguale allora controllo se anche minore di 'z' => Contenuto in lettere minuscole
    cmp bl , 'A'           ; Controllo con 'A'
    jae into_am            ; Se maggiore uguale allora controllo se anche minore di 'Z' => Contenuto in lettere maiuscole
    cmp bl , '0'           ; Controllo se è nel range numeri
    jae into_num
    jmp remove_confirm     ; Altrimenti il carattere non è una lettera e va rimosso
       
    into_a:
        cmp bl , 'z'
        ja remove_confirm
        jmp valid
    into_am:
        cmp bl , 'Z'
        ja remove_confirm
        jmp valid
    into_num:
        cmp bl , '9'
        jbe valid
        jmp remove_confirm
            
    remove_confirm:
        dec di             ; Se da togliere si fa uno skip del valore
        jmp remove 
             
    valid:                 ; Se il carattere non è da rimuovere si effettua il mascheramento per portarlo in minuscolo
    or bl , 00100000b
    mov [di] , bl          ; Si aggiunge il carattere minuscolo in una variabile per il crypt rot13
    jmp remove             ; Altrimenti è da rimuovere
 
   fine:                      
       lea si, to_encrypt + 1 ; Si passa al crypt impostando i puntatori
       lea di, output
   
   next_char:                 ; Parte del crypt con controllo valori validi
       mov al, [si]
       cmp al, '$'
       je print_result
   
       cmp al, 'a'
       jb store_result
       cmp al, 'z'
       ja store_result
   
       sub al, 'a'
       add al, 13
       cmp al, 26
       jl within_range
       sub al, 26
   
   within_range:
       add al, 'a'
       jmp store_result
   
   store_result:
       mov [di], al
       inc di
       inc si
       jmp next_char
   
   print_result: 
       mov ah , 09h
       lea dx , newline
       int 21h
       lea dx, output
       int 21h
              
ret
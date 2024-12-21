; Francesco Fontanesi XX/XX/XXXX
; Data una lettera da tastiera, stampare a schermo le successive 4 
; alternando Maiuscole e minuscole (esempio: mNoPq).

acapo_macro MACRO
    ;New Line
    mov ah , 2
    mov dl , 10
    int 21h 
    mov dl , 13 
    int 21h 
    ENDM

org 0100h

jmp start

str1 db 'Inserisci lettera: ', 0  ; Stringa per richiesta input
errorstr db 'Valore non valido', 0 ; Stringa per errore

start:
    ; Stampa la stringa "Inserisci lettera: "
    mov ah, 2
    lea bx, str1
print:
    cmp [bx], 00h             ; Controlla fine stringa
    je next                   ; Salta se la stringa è terminata
    mov dl, [bx]              ; Carica il carattere corrente
    inc bx                    ; Incrementa il puntatore
    int 21h                   ; Stampa il carattere
    jmp print                 ; Continua la stampa
next:
    ; Leggi un carattere da tastiera
    mov ah, 1
    int 21h
    mov bh, al                ; Salva il carattere in BH

    mov cl, 4                 ; Conta 4 lettere
    mov ah, 2                 ; Setup per la stampa

ciclo:
    inc bh                    ; Passa alla lettera successiva

    ; Controlla se il carattere è valido (lettera)
    cmp bh, 'a'
    jae Checkbh1              ; Se >= 'a', potrebbe essere minuscola
    cmp bh, 'A'
    jae Checkbh2              ; Se >= 'A', potrebbe essere maiuscola
    jmp error                 ; Altrimenti errore

Checkbh1:
    cmp bh, 'z'
    jle Lowercase_Bh          ; Se <= 'z', è minuscola
Checkbh2:
    cmp bh, 'Z'
    jle Uppercase_Bh          ; Se <= 'Z', è maiuscola

Lowercase_Bh:
    mov dh, 'l'               ; Flag per minuscola
    jmp go_on
Uppercase_Bh:
    mov dh, 'U'               ; Flag per maiuscola

go_on:
    cmp dh, 'l'               ; Se DH indica minuscola, salta a lowercase.
    je lowercase
    add bh, 20h               ; Converti in maiuscola.
    cmp bh, 'z'               ; Se oltre 'z', riparti da 'a'.
    ja over_uz
    jmp not_overuz

over_uz:
    mov bh, 'a'               ; Reset a 'a'.

not_overuz:
    mov dl, bh                ; Carica BH in DL per stampa.
    jmp common

lowercase:
    sub bh, 20h               ; Converti in minuscola.
    cmp bh, 'Z'               ; Se oltre 'Z', riparti da 'A'.
    ja over_lz
    jmp not_overlz

over_lz:
    mov bh, 'A'               ; Reset a 'A'.

not_overlz:
    mov dl, bh                ; Carica BH in DL per stampa.

common:
    int 21h                   ; Stampa il carattere.
    loop ciclo                ; Continua il ciclo finché CL > 0.
    jmp exit

error:
    acapo_macro               ; Vai a capo e stampa messaggio di errore.
    lea bx, errorstr
print_error:
    cmp [bx], 00h             ; Controlla fine stringa.
    je exit
    mov dl, [bx]              ; Carica carattere da stampare.
    inc bx
    int 21h
    jmp print_error

exit:
    ret                       ; Termina il programma.             

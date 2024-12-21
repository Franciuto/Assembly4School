; Francesco Fontanesi 26/11/2024
; Programma aggiornato per utilizzare SI al posto di BX per la gestione degli indirizzi.

org 0100h 

jmp start
    bye_string dw '...bye', 0
    lett1_string dw 'Lettera 1: ', 0
    lett2_string dw 'Lettera 2: ', 0


newline MACRO
    ; New Line
    mov ah, 2
    mov dl, 10
    int 21h 
    mov dl, 13 
    int 21h 
ENDM 

start:
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h

; Scrittura "Lettera 1: "
    lea si, lett1_string       ; Salvo in SI l'indirizzo della stringa
string1:                      
    cmp [si], 00h              ; Controllo tappo della stringa
    je prossimo                ; Esco dal ciclo
    mov dl, [si]               ; Carico il carattere in DL
    inc si                     ; Passo al prossimo indirizzo
    int 21h                    ; Stampo il carattere
    jmp string1                ; Ripeto il ciclo
        
prossimo:    ; Input lettera 1
    mov ah, 1
    int 21h
    mov bh, al
    newline

; Scrittura "Lettera 2: "
    lea si, lett2_string       ; Salvo in SI l'indirizzo della stringa
string2:                      
    cmp [si], 00h              ; Controllo tappo della stringa
    je go_on                   ; Esco dal ciclo
    mov dl, [si]               ; Carico il carattere in DL
    inc si                     ; Passo al prossimo indirizzo
    int 21h                    ; Stampo il carattere
    jmp string2                ; Ripeto il ciclo
go_on:
    mov ah, 1
    int 21h
    mov bl, al 
      
    newline
    
    xor ch, ch
    xor cl, cl
    
; Check lettera 1
    cmp bh, 'a'                ; Controllo se BH è >= 'a'
    jae Checkbh1               ; Se sì, controllo se è <= 'z'
    cmp bh, 'A'                ; Controllo se BH è >= 'A'
    jae Checkbh2               ; Se sì, controllo se è <= 'Z'
Check_Lettera_2:               ; Stessa cosa per BL
    cmp bl, 'a'
    jae Checkbl1
    cmp bl, 'A'
    jae Checkbl2
    jmp exit                   ; Salto all'uscita se le condizioni non sono soddisfatte

; Controlli lettera 1
Checkbh1:
    cmp bh, 'z'
    jle Lowercase_Bh           ; Se sì, imposto lowercase
    jmp Check_Lettera_2        ; Altrimenti controllo BL
Checkbh2:
    cmp bh, 'Z'
    jle Uppercase_Bh           ; Se sì, imposto uppercase
    jmp Check_Lettera_2        ; Altrimenti controllo BL
    
Checkbl1:                      ; Controllo BL per lowercase
    cmp bl, 'z'
    jle Lowercase_Bl
    jmp exit
Checkbl2:                      ; Controllo BL per uppercase
    cmp bl, 'Z'
    jle Uppercase_Bl
    jmp exit

; Scrittura nei registri corretti per le lettere (BH --> CH)    
Lowercase_Bh:
    mov ch, 'l'
    jmp Check_Lettera_2
Uppercase_Bh:
    mov ch, 'U'
    jmp Check_Lettera_2 

; Scrittura nei registri corretti per le lettere (BL --> CL)    
Lowercase_Bl:
    mov cl, 'l'
    jmp Continue
Uppercase_Bl:
    mov cl, 'U'
    
Continue:
    cmp ch, 'U'
    je bh_uppercase
controllo2:
    cmp cl, 'U'
    je bl_uppercase
    jmp next
bh_uppercase:
    add bh, 20h
    jmp controllo2
bl_uppercase:
    add bl, 20h
    jmp next
next:    
; Controllo se le lettere sono uguali
    cmp bh, bl
    je exit
        
; Controllo se sono in ordine lessicografico    
    cmp bh, bl
    ja false
        
; Se sono in ordine, scrivo le lettere comprese    
included:
    cmp bh, bl
    je start
    inc bh
    mov dl, bh
    int 21h
    jmp included
        
; Scrivo "N", newline, e reinizio il programma
false:
    mov ah, 2
    mov dl, 'N'
    int 21h
    jmp start
        
; Chiudo il programma scrivendo "...bye"    
exit:
    lea si, bye_string         ; Salvo in SI l'indirizzo della stringa
print_bye:                      
    cmp [si], 00h              ; Controllo tappo della stringa
    je return                  ; Esco dal ciclo
    mov dl, [si]               ; Carico il carattere in DL
    inc si                     ; Passo al prossimo indirizzo
    int 21h                    ; Stampo il carattere
    jmp print_bye              ; Ripeto il ciclo
        
return:
    ret
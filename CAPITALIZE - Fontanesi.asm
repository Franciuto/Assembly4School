; Francesco Fontanesi 22/11/2024
; CAPITALIZE: Data una lettere minuscola in input stampa la corrispondente maiuscola 
; (qualsiasi altro carattere viene ignorato). Il programma continua a fare a conversione 
; e si interrompe solo alla pressione della barra spaziatrice, stampando poi un saluto. 

;+----+----+
;| AH | AL |
;+----+----+
;| BH | BL |
;+----+----+
;| CH | CL |
;+----+----+
;| DH | DL |
;+----+----+
;| SI      |
;+---------+
;| DI      |
;+---------+
;| BP      |
;+---------+
;| SP      |
;+---------+

start:

    ;Input utente
    mov ah , 1         
    int 21h
    cmp al , ' '            ;Controllo se l'utente clicca la barra spaziatrice
    je exit                 ;Se la clicca vado alla chiusura del programma
    mov bh , al
    
    mov  ah , 2             ;Setup scrittura 
    cmp bh , 'a'            ;Confronto il valore ascii di a (30) con al (input utente)
    jb error                ;Se al è minore di 'a' allora non fa parte delle lettere minuscole --> Passo a "error"
    cmp bh , 'z'            ;Confronto il valore ascii di z (7A) con al (input utente)
    ja error                ;Se al è maggiore di 'z' allora non fa parte delle lettere minuscole --> Passo a "error"
    
    mov dl , '-'
    int 21h
    mov dl , '>'
    int 21h
    sub bh , 20h            ;Sottraggo ad al 20h ossia la differenza tra la lettera in maiuscolo e minuscolo nella tabella ascii
    mov dl , bh             ;Sposto il valore da stampare in dl  
    int 21h 
    ;Vado a capo
    mov dl , 10
    int 21h
    mov dl , 13
    int 21h 
    
    jmp start                ;Salto a start per reiniziare il programma

;Scrivo error se il valore non e' una lettera minuscola
error:   
    ;Print "ERROR"
    mov dl , 13
    int 21h
    mov dl , 'E'
    int 21h
    mov dl , 'R'
    int 21h  
    mov dl , 'R'
    int 21h
    mov dl , 'O'
    int 21h
    mov dl , 'R'
 
exit:
    ;Scrittura "Bye!" 
    mov ah , 2 
    mov dl , 10
    int 21h
    mov dl , 13
    int 21h
    mov dl , 'b'
    int 21h
    mov dl , 'y'
    int 21h
    mov dl , 'e'
    int 21h 
    mov dl , '!'
    int 21h
    
    ret
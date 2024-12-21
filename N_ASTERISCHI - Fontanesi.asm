; Francesco Fontanesi 22/11/2024
; N_ASTERISCHI: Data un numero N compreso tra 0 e 9, stampa una riga di N asterischi di colori diversi. 

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

;Input utente
mov ah , 1
int 21h
mov bl , al             ;Libero al   
xor bh , bh             ;Inizializzo bh a 0
;Setup memoria video
mov ax , 0b800h        
mov si , 2              ;Inizio dall'indirizzo 2 perchè i primi due sono già occupati dall'input
mov es , ax
;Controllo che il valore inserito sia un numero valido
cmp bl , '0'            ;Confronto il valore ascii di a (30) con al (input utente)
jb error                ;Se al è minore di 'a' allora non fa parte delle lettere minuscole --> Passo a "error"
cmp bl , '9'            ;Confronto il valore ascii di z (7A) con al (input utente)
ja error                ;Se al è maggiore di 'z' allora non fa parte delle lettere minuscole --> Passo a "error"
;Imposto il ciclo
mov cl , bl
sub cl , '0'            ;Sottraggo 30 al numero per renderlo corretto per il ciclo

;Loop che stampa gli asterischi
    asterischi:
    mov es:[si] , '*'   ;Muovo l'asterisco in memoria video
    inc bh              ;Passo al colore successivo
    inc si              ;Passo all'indirizzo di memoria video successivo
    mov es:[si] , bh    ;Imposto il formato del colore
    inc si              ;Passo all'indirizzo di memoria video successivo
    loop asterischi    
    jmp exit            ;A loop finito termino il programma



;Stampo error se il valore non è un numero valido
error:
    mov ah , 2   
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
    int 21h 

exit:
    ret





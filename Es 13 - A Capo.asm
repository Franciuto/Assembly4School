; Francesco Fontanesi 22/11/2024
; A_CAPO: Data una cifra N stampa, a capo, la precedente se minore di 5, la successiva se maggiore o uguale. 

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


mov ah , 1
int 21h
mov ah , 2
mov bl , al

cmp bl , '0'            ;Confronto il valore ascii di a (30) con al (input utente)
jb error:               ;Se al è minore di 'a' allora non fa parte delle lettere minuscole --> Passo a "error"
cmp bl , '9'            ;Confronto il valore ascii di z (7A) con al (input utente)
ja error:               ;Se al è maggiore di 'z' allora non fa parte delle lettere minuscole --> Passo a "error"

mov dl , 10             ;Line Feed
int 21h
mov dl , 13             ;Carriage return
int 21h  

cmp bl , '0'            ;Confronto al con 0
je exit                 ;Se il risultato tra il cmp e'0 quindi se (n e' zero --> 0-0 = 0) salto a exit per terminare e non stampare numeri minori di 0
cmp bl , '5'            ;Confronto con 5
jb minore               ;Se al è minore di 5 allora salto a minore
jae maggiore_uguale     ;Se al è maggiore o uguale a 5 allora salto a maggiore
jmp exit                ;Salto a jump per finire il programma nel caso in cui non sia nessuna delle precedenti

minore:
    dec bl              ;Sottraggo 1 al numero 
    jmp exit            ;Salto a exit
    
maggiore_uguale:
    inc bl              ;Aggiungo 1 al numero
    jmp exit            ;Salto a exit


;Stampo error se il valore non è un numero
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
    mov dl , bl
    int 21h
    ret





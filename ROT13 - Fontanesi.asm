; Francesco Fontanesi 01/11/2024
; "ROT13" - Implementare un prog. con emu 8086 che riceve in input parole fino a 10 caratteri. 
; All'inserimento di ogni lettera, stampa accanto la traslata di 13 posti (ad es. A -> N), va a capo e accetta la successiva lettera.   

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

;Setup registri        
mov cl , 10         ;Registro counter per "Iterazione"   

;Ciclo Main
iterazione:         ;Ciclo che ripete la serie di istruzioni per 10 volte
    mov ah , 1          ;Setup registro per funzione input
    int 21h             ;Richiesta input
    sub al , 'a'        ;Sottrae il valore ASCII della lettera 'a' in modo da avere una comparazione tra lettere e numeri comparabile
    add al , 13         ;Aggiunge al nuovo valore 13 per eseguire la rotazione di 13 (però nel codice ASCII)
    cmp al , 26         ;Compara il numero ottenuto con la totalità dei valori ASCII 
    jl case_minore      ;Utilizzando il "Jump Lower" eseguo delle determinate istruzioni specificate in "case_minore" se il primo numero è minore del secondo (Quindi per intenderci se il valore rotato ottenuto è compreso nei valori ASCII delle lettere il codice in "case_lower" viene eseguito)
    sub al , 26         ;Se il numero esce fuori dai valori ASCII delle lettere, per evitare di stampare valori rotati non corrispondenti a lettere vado a sottrarre 26 per riportare il valore nell'intervallo a-z 
    case_minore:        
        add al , 'a'        ;SE il numero è minore di 26 quindi se è incluso nell'intervallo a-z gli viene riaggiunto 'a' quindi il valore precedentemente sottratto 
    mov ah , 2          ;Setup registro stampa
    mov dl , al         ;Stampa nuova lettera cirfrata
    int 21h             
    mov dl , 10         ;Line feed          ------->
    int 21h                                             ;Queste istruzioni servono per andare a capo
    mov dl , 13         ;Carriage return    -------> 
    int 21h

loop iterazione

ret
; Francesco Fontanesi 10/19/2024

; Scrivere e collaudare un programma che permette di salvare in memoria, a partire dalla locazione 200h, il vostro cognome, 
;inserito da tastiera. Il programma ristampa poi il cognome incrementando ogni lettera di 2. 

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

;Scrittura CLI
mov AH , 2
mov DL , 'L'
int 21h
mov DL , 'e'
int 21h 
mov DL , 'n'
int 21h 
mov DL , 'g'
int 21h
mov DL , 'h'
int 21h
mov DL , 't'
int 21h
mov DL , '='
int 21h 


;Chiede all'utente la lunghezza del suo cognome
mov AH , 1
int 21h                 
sub AL , 30h            ;Sottrae all'imput 30 per convertire da valore esadecimale dell'ascii a corrispondente valore decimale inserito
mov CL , AL             ;Salva il numero di iterazioni da fare su CL per liberare AL per input successivi (CL perchè descrizione di "LOOP" è "Decrease CX, jump to label if CX not zero")
mov [0220h] , CL         ;Salva in memoria il numero originale delle iterazioni da fare
mov BX , 0200h          ;Imposta su locazione 16 bit BX l'indirizzo di memoria di partenza
           
;Pulizia schermo
mov AH , 00
mov AL , 00
int 10h
mov AH , 1           
                   
;Salvataggio in memoria
iterazione:             ;LABLE per il LOOP
int 21h                 
mov [BX], AL            ;Muove il valore inserito nella locazione di memoria indicata da BX
add BX , 1              ;Scala BX alla locazione di memoria successiva
loop iterazione         ;Ripete l'iterazione partendo dalla lable "iterazione"

;Pulizia schermo
mov AH , 00
mov AL , 00
int 10h
mov AH , 1 

mov AH , 2              ;Setup scrittura
mov BX, 0200h           ;Reset indirizzo originale
mov CL , [0220h]        ;Reset iterazioni inizali

inversione:
mov DL , [BX]           ;Spostamento valore da memoria a registro
add DL , 2h             ;Operazione di aggiunta di 2 (per scalare di due lettere)
add BX , 1h             ;Incremento dell'indirizzo di memoria per andare a spostare il valore successivo alla prossima iterazione
int 21h                 ;Scrive il valore
loop inversione         ;Ripete l'iterazione partendo dalla lable "inversione"





ret



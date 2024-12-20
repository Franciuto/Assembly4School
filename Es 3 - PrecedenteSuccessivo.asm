; Francesco Fontanesi 10/19/2024 

; Scrivere e collaudare un programma che legge una lettera da tastiera e stampa la 
; precedente e la successiva. A commento Spiegare perché il programma va in errore per la 'a' 
; e per la 'z'.

+----+----+
| AH | AL |
+----+----+
| BH | BL |
+----+----+
| CH | CL |
+----+----+
| DH | DL |
+----+----+
| SI      |
+---------+
| DI      |
+---------+
| BP      |
+---------+
| SP      |
+---------+


;Setup lettura
mov AH , 1

;Input lettera 1       
int 21h 
mov BH , AL

;Pulizia Schermo
mov AH , 00
int 10h

;Setup scrittura
mov AH , 2

;Scrittura lettera precedente
add BH , 1 ;Aggiungo al valore esadecimale "1" in modo da scalare sulla lettera ascii successiva
mov DL , BH ;Sposto il valore in "DL" perchè l'output cerca di default il valore da stampare in locazione DH
int 21h ;Scrivo la lettera precedente

;Scrittura lettera inserita
sub BH , 1 ;Sottraggo al valore aumentato di "1" un'altro "1" in modo da annullare l'operazione  e tornare all'originale
mov DL , BH  ;Sposto il valore in "DL" perchè l'output cerca di default il valore da stampare in locazione DH
int 21h ;Scrivo la lettera in mezzo

;Scrittura Lettera successiva
sub BH , 1 ;Sottraggo al valore originale "1" per ottenere la lettera successiva
mov DL , BH ;Sposto il valore in "DL" perchè l'output cerca di default il valore da stampare in locazione DH
int 21h ;Scrivo la lettera 2

; Il programma non funziona con A e Z perche' quando andiamo a inserire il valore "a" in memoria viene salvato il suo corrispettivo esadecimale del codice ascii
; quindi (a = 61) e andando quindi a sottrarre (61 - 1 = 60) che non e' giustamente uguale a Z ma corrisponde alla lettera "'" in ascii 

; Stessa cosa per la lettera Z

ret





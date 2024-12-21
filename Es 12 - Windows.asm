; Francesco Fontanesi 18/11/2024
; Implementare un prog. con emu 8086 che consente di inserire una cifra da tastiera, stampa il conto alla rovescia a partire dal numero inserito fino a zero, ogni numero di un colore diverso.

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

mov dx , 0b800h
mov es , dx         ;Impostazione primo segmento della memoria video

;Richiesta input dall'utente
mov ah , 1
int 21h

sub al , '0'        ;Sottrazione del valore ascii di 0 (30) dall'input per avere l'effettivo numero di ripetizioni da fare
mov cl , al         ;Setup del regisrto cl con le ripetizioni da fare nel ciclo
mov si , 0002h      ;Setup del registro si per iniziare a stampare in memoria dal secondo spazio dello schermo in quanto il primo è occupato dall'input dell'utente 

mov bl , 1          ;Setup registro per counter dei colori da usare
      
print:
sub al , 1          ;Sottrazione dall'input di 1 per fare l'effettivo countdown
add al , '0'        ;Aggiunta del corrispettivo ascii di 0 (30) in modo da portare il numero (es: 4) nel corrispettivo ascii del 4 ossia 34
mov es:[si] , al    ;Sposto tramite l'indirizzamento indiretto usando la segmentazione il valore del numero da stampare nell'indirizzo della memoria video
inc bl              ;Incremento il colore
inc si              ;Vado alla coppia di bit successiva nella memoria video per impostare la formattazione
mov es:[si] , bl    ;Vado a settare il formato come 0000 + bl ossia foreground = valore contenuto in bl (dato che possiamo inserire solo una cifra nel countdown non c'è modo che incrementando bl si possa superare il 15 ossia il numero che corrisponde al colore massimo)
inc si
sub al , '0'        ;Sottraggo al valore stampato nuovamente 30 per riportarlo in formato corretto 


 
loop print



ret





; Francesco Fontanesi 1/11/2024
; Implementare un prog. con emu 8086 che consente di inserire una cifra da tastiera, 
; quindi va a capo e stampa il conto alla rovescia a partire dal numero inserito fino a zero. 

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
mov ah , 1			;Setup AH per eseguire istruzione richiesta input
int 21h				;Richiesta input
sub al , '0'		;Sottrae ad al il valore ASCII di 0 ossia 30 in modo da avere un numero valido da inserire nel ciclo
mov cl , al			;Attribuisce al registro CL il valore inserito in input - 30 in modo da eseguire il ciclo dal numero inserito a 0 e quindi di conseguenza da eseguire il conto alla rovescia fino a 0
add al , '0'		;Riaggiungo al valore inserito 30 in modo da farlo ricombaciare con il corrispettivo codificato ASCII

ciclo:
	sub al , '0'		;Sottraggo al valore inserito 30
	mov ah , 2			;Setup del registro per la scrittura
	sub al , 1			;Sottraggo 1 in modo da andare a selezionare il valore minore
	mov dh , al			;Sposto su DH per non "corrompere" il valore di input
	add dh , '0'		;Aggiungo al numero da stampare 30 per riportarlo al suo corrispondente nella codifica ASCII
	mov dl , 10			;Line feed
	int 21h
	mov dl , 13			;Carriage return
	int 21h 
	mov dl , dh			;Muove valore da stampare in DL
	int 21h

loop ciclo

ret

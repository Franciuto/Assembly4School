; Francesco Fontanesi 10/29/2024
; Implementare un prog. con emu 8086 che popola le locazioni di memoria a partire da 0xggmmh 
; con i caratteri stampabili del codice ASCIII, dove mm è il vostro mese di nascita e gg il vostro giorno di nascita

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

;Locazioni di memoria da utilizzare
;   formato: GGMM   (GG = Giorno MM = Mese)
;   (Giorno = 07 Mese = 04
;   relativa cella da utilizzare: 0704h


;Setup
mov ah , 1          ;Setup scrittura
mov di , 0704h      ;Setup indirizzo per accesso indiretto memoria  
mov cl , 4          ;Setup registro per iterare 

;Scrittura in memoria
iterazione:
int 21h
mov [di], al
add di , 1
loop iterazione

ret





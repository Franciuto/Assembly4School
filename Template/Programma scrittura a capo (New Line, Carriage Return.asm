; Francesco Fontanesi XX/XX/XXXX
; Consegna 

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


org 100h

;Print primo valore
mov ah , 2 
mov dl , 'a'
int 21h

;Line feed, Carriage return
mov dl , 10                         ;Muove codice 10 == Line feed
int 21h
mov dl , 13                         ;Muove codice 13 == Carriage return
int 21h

;Print secondo carattere
mov dl , 'b'
int 21h   
   
   
ret





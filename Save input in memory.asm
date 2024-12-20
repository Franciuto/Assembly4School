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
          
;Setup registri
mov BX , 0100h          ;Setup registro per salvataggio in memoria
mov CX , 19             ;Setup numero iterazioni da svolgere per salvare il MIO nome e cognome
mov AH , 1              ;Setup registro per scrittura
         
;Ciclo per scrittura in memoria
salvataggio:
int 21h
mov [BX] , AL
add BX , 1
loop salvataggio

;Pulizia schermo
mov AH , 00
mov AL , 00
int 10h
mov AH , 1

;Setup scrittura
mov CX , 19             ;Setup variabile per ripetere il ciclo
mov AH , 2              ;Setup scrittura
mov BX , 0100h          ;Setup inidizzo prima lettera

;Ciclo per output
output:
mov DL , [BX]           ;Movimento lettera in memoria per scrittura
int 21h                 ;Scrittura
add BX , 1              ;Incremento indirizzo
loop output


ret





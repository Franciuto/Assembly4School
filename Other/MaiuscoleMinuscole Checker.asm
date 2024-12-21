; Francesco Fontanesi XX/XX/XXXX
; Consegna 

;	+----+----+
;	| AH | AL |
;	+----+----+
;	| BH | BL |
;	+----+----+
;	| CH | CL |
;	+----+----+
;	| DH | DL |
;	+----+----+
;	| SI      |
;	+---------+
;	| DI      |
;	+---------+
;	| BP      |
;	+---------+
;	| SP      |
;	+---------+


mov ah , 1
int 21h
mov ah , 2

cmp al , 'A'
jb other
cmp al , 'Z'
ja other

mov dl , 'y'

jmp exit

other:
mov dl , 'n'
       
       
exit:
int 21h       
ret

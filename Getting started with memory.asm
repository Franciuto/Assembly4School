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

mov di , 0200h
mov [di] , 'F'
inc di 

mov [di] , 'o'
inc di
  
mov [di] , 'n'
inc di

mov [di] , 't'
inc di

mov [di] , 'a'
inc di

mov [di] , 'n'
inc di

mov [di] , 'e'
inc di

mov [di] , 's'
inc di
  
mov [di] , 'i'
inc di
ret
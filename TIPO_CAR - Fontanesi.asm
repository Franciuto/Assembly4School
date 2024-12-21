; Francesco Fontanesi 11/26/2024
; Dato un'input scrivere
;   C se è una cifra
;   L se è una lettera
;   A se altro 

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


tipo_car:
    ;User input
    mov ah , 1
    int 21h
    mov bh , al

    ;Check if stop
    cmp bh , '\'
    je exit
    ;Check if letter
    cmp bh , 'a'
    jge checkLowercase
    cmp bh , 'A'
    jge checkUppercase 
    ;Check if digit
    cmp bh , '0'
    jge checkDigit
    
    jmp other   ;Se non è ne lettera ne Digit vado a Other
     
    ;Controllo se compreso tra range di lettere minuscole 
    checkLowercase: 
        cmp bh , 'z'
        jle letter 
    ;Controllo se compreso tra range di lettere maiuscole 
    checkUppercase:
        cmp bh , 'Z'
        jle letter 
    ;Controllo se compreso tra range di numeri da 0 a 9
    checkDigit:
        cmp bh , '9'
        jle digit      
    
    
    ;Preparo la lettera in base alla categoria
    other:
        mov cl , 'O'
        jmp graphic
    
    digit:
        mov cl , 'C'
        jmp graphic
    
    letter:
        mov cl , 'L'

    ;Scrivo la freccia
    graphic:
        mov ah , 2
        mov dl , ' '
        int 21h
        mov dl , '-'
        int 21h
        mov dl , '>'
        int 21h
        mov dl , ' ' 
        int 21h
        mov dl , cl         ;Stampo la lettera
        int 21h
        ;Vado a capo
        mov dl , 10
        int 21h
        mov dl , 13
        int 21h
        jmp tipo_car
    
exit:
    ret  

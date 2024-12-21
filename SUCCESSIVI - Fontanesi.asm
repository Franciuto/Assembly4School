; Francesco Fontanesi 26/11/2024
; SUCCESSIVI - Leggere due caratteri da tastiera e stampare 'S' se sono successivi sulla tavola scii, 'N' altrimenti.

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


;BH --> Lettera 1
;BL --> Lettera 2
;CH --> Stato lettera 1 (l = Lowercase  U = Uppercase)
;CL --> Stato lettera 2 (l = Lowercase  U = Uppercase)


;Scrittura "Lettera 1:
mov ah , 2 
mov dl , 'L'
int 21h
mov dl , 'e'
int 21h
mov dl , 't'
int 21h
mov dl , 't'
int 21h
mov dl , 'e'
int 21h
mov dl , 'r'
int 21h
mov dl , 'a'
int 21h     
mov dl , ' '
int 21h
mov dl , '1'
int 21h
mov dl , ':'
int 21h
mov dl , ' '
int 21h      

;Input lettera 1
mov ah , 1
int 21h
mov bh , al 


;Vado a capo
mov ah , 2
mov dl , 10
int 21h
mov dl , 13
int 21h

;Scrittura "Lettera 2:
mov dl , 'L'
int 21h
mov dl , 'e'
int 21h
mov dl , 't'
int 21h
mov dl , 't'
int 21h
mov dl , 'e'
int 21h
mov dl , 'r'
int 21h
mov dl , 'a'
int 21h     
mov dl , ' '
int 21h
mov dl , '2'
int 21h
mov dl , ':'
int 21h
mov dl , ' '
int 21h      

;Input lettera 2
mov ah , 1
int 21h
mov bl , al

;Check lettera 1
cmp bh , 'a'
jae Checkbh1
cmp bh , 'A'
jae Checkbh2
Check_Lettera_2:
    ;Check lettera 2
    cmp bl , 'a'
    jae Checkbl1
    cmp bl , 'A'
    jae Checkbl2
    
jmp error
    
;Controlli lettera 1
Checkbh1:
    cmp bh , 'z'
    jle Lowercase_Bh
    jmp Check_Lettera_2
Checkbh2:
    cmp bh , 'Z'
    jle Uppercase_Bh
    jmp Check_Lettera_2
;Controlli lettera 2
Checkbl1:
    cmp bl , 'z'
    jle Lowercase_Bl
    jmp error
Checkbl2:
    cmp bl , 'Z'
    jle Uppercase_Bl
    jmp error     

;Scrittura nel registro corretto per determinare le lettere (BH --> CH)    
Lowercase_Bh:
    mov ch , 'l'                                              ;  CH = "l" --> BH è Lowercase
    jmp Check_Lettera_2                                       ;  CH = "U" --> BH è UPPERCASE
Uppercase_Bh:
    mov ch , 'U'
    jmp Check_Lettera_2 
;Scrittura nel registro corretto per determinare le lettere (BL --> CL)    
Lowercase_Bl:
    mov cl , 'l'                                              ;  CL = "l" --> BL è Lowercase
    jmp Continue                                              ;  CL = "U" --> BL è UPPERCASE
Uppercase_Bl:
    mov cl , 'U' 
    
Continue:
cmp cl , ch         ;Se i caratteri non sono "omogenei" allora non possono essere consecutivi in nessun caso
jne false  

cmp bh , bl         ;Se le lettere sono ugali non ha senso eseugire l'algoritmo
je error

mov dh , bh
mov al , dh
dec dh             ;DH => Lettera precedente della prima
inc al             ;AL => Lettera successiva della prima

cmp ch , 'l'       ;Confronto la prima lettera con l per capire se è o non è maiuscola
je ctrl_fix_lowercase
jmp CTRL_FIX_UPPERCASE

;Se è in minuscolo
ctrl_fix_lowercase:
    cmp dh , 'a'   ;Confronto dh con 'a' perchè essendo a decrementato può andare solo in negativo e può quindi sforare solo la a
    jb fix_a_l
    cmp al , 'z'   ;Confronto al con 'z' perchè essendo a aumentato può andare solo in positivo e può quindi sforare solo la z
    ja fix_z_l
    jmp next

CTRL_FIX_UPPERCASE:
    cmp dh , 'A'  ;Confronto dh con 'A' perchè essendo a decrementato può andare solo in negativo e può quindi sforare solo la A
    jb fix_A_U
    cmp al , 'Z'  ;Confronto dh con 'Z' perchè essendo a decrementato può andare solo in negativo e può quindi sforare solo la Z
    ja fix_A_U
    jmp next
     
;Se sfora la a allora resetto sulla z
fix_a_l:
    mov dh , 'z'
    jmp next
;Se sfora la z allora resetto sulla a
fix_z_l:
    mov al , 'a'
    jmp next
;Se sfora la A allora resetto sulla Z
fix_A_U:
    mov dh , 'Z'
    jmp next
;Se sfora la A allora resetto sulla \A 
fix_Z_U:
    mov al , 'A'
    jmp next




Next:
    cmp dh , bl         ;Confronto la lettera precedente alla prima con la seconda
    je true
    cmp al , bl         ;Confronto la lettera successiva alla prima con la seconda
    je true

    jmp false 

;Stampo "S" a capo
true:  
    mov ah , 2
    mov dl , 10
    int 21h
    mov dl , 13
    int 21h
    mov dl , 'S'
    int 21h
    jmp exit

;Stampo "N" a capo
false:
    mov ah , 2
    mov dl , 10
    int 21h
    mov dl , 13
    int 21h
    mov dl , 'N'
    int 21h
    jmp exit

error:
    mov ah , 2
    mov dl , 10
    int 21h
    mov dl , 13
    int 21h
    mov dl , 'E'
    int 21h
    mov dl , 'R'
    int 21h
    mov dl , 'R'
    int 21h
    mov dl , 'O'
    int 21h
    mov dl , 'R'
    int 21h 
    mov dl , '!'
    int 21h   

exit:
    ret    
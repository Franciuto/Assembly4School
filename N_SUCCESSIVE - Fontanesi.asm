; Francesco Fontanesi 22/11/2024
; N_SUCCESSIVE: Data una lettera C ed una cifra N inserite da tastiera stampa gli N caratteri successivi alla lettera data 

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

;Input utente
mov ah , 2
mov dl , 'C'            ;Lettera (C) ---> registro BH
int 21h
mov ah , 1
int 21h 
mov bh , al
mov ah , 2
mov dl , 'N'            ;Cifra (N) -----> registro BL
int 21h
mov ah , 1
int 21h
mov bl , al
mov ah , 2
;New line
mov ah , 2
mov dl , 10             ;Line Feed
int 21h
mov dl , 13             ;Carriage return
int 21h
                      
sub bl , '0'            ;Sottraggo al valore inserito nella cifra 30 per renderlo valido in modo da impostare un ciclo
mov cl , bl             ;Imposto il ciclo

next_chars:
    inc bh              ;Incremento BH per prendere in considerazione la cifra successiva
    cmp bh , 'z'        ;Confronto il valore con la 'z'
    ja zmag_fix         ;Se il valore supera la 'z' è indubbiamente fuori scala e quindi alla parte per risolvere il problema
    cmp bh , 'Z'        ;Confronto il valore con la 'Z'
    ja istofix          ;Se è maggiore significa che si sta andando fuori scala nelle lettere maiuscole ma potrebbe essere che sia semplicemente il valore di una lettera minuscola che si trova infatti dopo la scala delle lettere maiuscole
    jmp continue        ;Se nessuno dei jump viene applicato salto direttamente al continuo del ciclo


istofix:
    cmp bh , 'a'        ;Verifico che il valore sia minore della lettera 'a' perchè in tal caso significa che, il valore SUPERIORE A 'Z' non è un valore di una lettera minuscola 
    jb Z_fix            ;Di conseguenza posso procedere a risolvere questo problema
    jmp continue        ;Se il valore invece è maggiore di 'a' significa che rientra nei valori minuscoli e che quindi questo aggiustamento non è necessario
    
Z_fix:                  
    mov bh , 'A'        ;Imposto bh ad 'A' per riportare il valore sulla scala
    jmp continue        ;Continuo il ciclo
    
    
zmag_fix:
    mov bh , 'a'        ;Imposto bh ad 'a' per riportare il valore sulla scala
    jmp continue        ;Continuo il ciclo  
  
   
continue:
    mov dl , bh         ;Muovo bh in dl per la stampa
    int 21h 
    loop next_chars 
        
    ret





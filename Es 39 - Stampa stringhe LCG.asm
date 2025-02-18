;Programma che richiede una parola in input
; e un intero N tra 0 e 100
; Il programma cancella lo schermo e scrive N volte la
; parola in posizioni casuali



;*************************************************************
;*        DATA SECTION
;*************************************************************

data segment
    result     dw    0
    loop_ct    dw    0 
    N          dw    0
    str        db    10, ?, 10 dup('$')   
    n_input    db    7, ?, 6 dup()
    msg1       db    "Inserire una parola: $"
    msg2       db    10, 13, "Inserire il numero intero: $" 
    seed       dw    ?  
    righe      dw    25
    colonne    dw    80  
    x          dw    0
    y          dw    0
    
ends                                    

;*************************************************************
;*        STACK SECTION
;*************************************************************
stack segment
    dw  128  dup(0)
ends

;*************************************************************
;*        DATA SECTION
;*************************************************************
code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

; Prompt inserimento parola
   mov ah , 9h
   lea dx , msg1
   int 21h

; Inserimento parola
   mov ah , 0ah
   lea dx , str
   int 21h   
    
; Prompt inserimento N
   mov ah , 9h
   lea dx , msg2
   int 21h
   
; Inserimento N
   mov ah , 0ah
   lea dx , n_input 
   int 21h
   lea ax , n_input + 2
   call str2int               ; conversione in stringa
   mov ax , result
   mov n , ax
   mov cx , n                 ; ciclare N volte la stampa

sloop:      
; Inizializzazione
    mov n , cx
    call cls
    call srand  
       
; DL = casuale.tra(0,80)    
    xor ax,ax 
     
    push ax   
    push colonne    
    call casuale_tra 
    pop x

; DH = casuale.tra(0,25)   
    xor  ax,ax
    push ax   
    push righe    
    call casuale_tra 
    pop y
    
    mov DX, x
    mov AX, y
    mov DH, AL    
            
            
    lea si, str
    inc si         
    mov CL, [si] 
   ; Imposto cursore
      mov bh , 0
      mov dx , Y
      mov ax , X
      mov dl , al
      xor ax , ax
      mov ah , 02h
      int 10h
      
      mov ah , 9h
      lea dx , str + 2
      int 21h
   mov cx , n  
   loop sloop

    
    mov ax, 4c00h
    int 21h    
ends


;*************************************************************
;*       PROCEDURES SECTION
;*************************************************************


;*************************************************************
;* Procedura:   srand 
;* description: initialize 'seed' variable (must be declare as dw)
;* input:       none
;* return:      none
;*************************************************************
srand PROC
    MOV AH, 00h   ; Funzione per leggere il timer 
    INT 1Ah       
    MOV seed, DX  ; Salva il valore del timer in seed
    RET
srand ENDP  

;*************************************************************
;* Procedura:   rand 
;* description: generate a new pseudocasual integer between 0 e 2^16-1 
;* input:       none
;* return:      pseudocasual integer between  0 e 2^16-1 passed by stack
;*************************************************************

rand PROC
    ; Incrementa il seed 
    POP BP
    
    MOV AX, seed
    ADD AX, 1
    MOV seed, AX
    
    ;LCG psudocasual
    MOV BX, 1035h
    MUL BX   ; DX AX
    ADD AX, 12345       ; N % 65536
    MOV seed, AX
    
    ; Ritorna il numero casuale nello stack
    PUSH AX
    PUSH BP
    RET
rand ENDP

;*************************************************************
;* Procedura:   str2int
;* description: converts a string (containing a number) into an integer
;* input:       string containing a number (offset in ax)
;* return:      unsigned max 16 bit number (ax)
;*************************************************************

str2int proc
   mov bx , 10
   mov si , ax
   convert_loop:
      xor ah , ah
      mov al , [si]                  ; Carica il carattere in al
      cmp al , 0dh                   ; Controllo con terminatore a capo
      je done                        ; Uscita dal ciclo
         
      sub al , '0'                   ; Converte da ascii a numero
      mov cx , ax                    ; Salva il numero corrente in cx
      mov ax , result                ; Carico il risultato definitivo in ax
      mul bx                         ; ax = ax * 10 (sposta a sinistra le cifre)
      add ax , cx                    ; Somma il nuovo numero come unità
      mov result , ax                ; Salva il nuovo risultato
         
      inc si                         ; Passo al prossimo carattere
      jmp convert_loop               ; Continuo il ciclo

   done:
      mov ax , result
      ret
      
;*************************************************************
;* Procedura:   casuale_tra 
;* description: generate a pseudocasual integer between min e max passed by stack
;* input:       min ean maxnone
;* return:      pseudocasual integer througth stack
;*************************************************************

casuale_tra PROC
    ; Riceve min e max dallo stack 
    pop BP 
    
;LCG algorithm    
    MOV AX, seed
    ADD AX, 1
    MOV seed, AX
    MOV BX, 1035h
    MUL BX
    ADD AX, 12345
    MOV seed, AX
    
    
    
    POP BX       ; max
    POP CX       ; min
    
    ; Genera un numero casuale
    ; CALL rand   ; NON POSSO fare CALL ricorsive!!!!!!!!!!!!!!!!
    ; POP AX       ; Ottiene il numero casuale
    

    ; Calcola il numero casuale tra min e max
    SUB BX, CX   ; max - min 
    XOR DX, DX
    DIV BX       ; (numero casuale % (max - min))
    ADD DX, CX   ; + min
    
    ; Ritorna il numero casuale nello stack
    PUSH DX 
    PUSH BP
    RET
casuale_tra ENDP

cls PROC
    MOV AH, 06h  ; Funzione di scroll
    MOV AL, 0    ; Scrolla l'intero schermo  (00h = clear entire window)
    MOV BH, 07h  ; Attributo (sfondo nero, testo bianco)
    MOV CX, 0    ; Coordinata superiore sinistra (riga 0, colonna 0)
    MOV DX, 184Fh ; Coordinata inferiore destra (riga 24, colonna 79) per schermi 80x25
    INT 10h      ; Chiamata all'interrupt video      
    RET
cls ENDP    
end start

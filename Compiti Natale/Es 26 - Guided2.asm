; Francesco Fontanesi 31/12/2024
; Stampa di un numero unsigned a due cifre (hard-coded)

data segment
   num db  72
   text db 'Stampa valore unsigned a due cifre (hard-coded)$'
ends

stack segment

ends

code segment
start:
    ; Setup
    mov ax, data
    mov ds, ax
    mov es, ax
     
    ; Scrittura descrizione programma
    lea dx , text
    mov ah , 9h
    int 21h
    mov ah , 2h
    mov dl , 13
    int 21h
    mov dl , 10
    int 21h 
   
    mov al , num      ; Carico il valore               
    xor ah , ah       ; Reset ah
    lea si , num + 2  ; Carico cifra 1
    mov bl , 10
    div bl            ; Effettuo la divisione
    mov bl , ah
    
    ; Conversione in ascii di decina e unità 
    add ah , '0'        ; Unità
    add al , '0'        ; Decina       
    
    ; Stampa entrambi le cifre
    mov bx , ax        ; Copia ax in bx
    mov ah , 2h        
    mov dl , bl        ; Carcio Decina
    int 21h
    mov dl , bh        ; Carico Unità
    int 21h            
ends

end start

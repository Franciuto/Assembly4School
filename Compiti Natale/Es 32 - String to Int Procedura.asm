; Francesco Fontanesi 05/01/2025
; partendo dall’esercizio precedente, trasforma il codice nella procedura GETINT che permette di inserire un numero da tastiera 
; e lo ritorna mediante il registro AX.

; Il programma supporta numeri fino a 65535 

.model SMALL
.stack 100h
.data
   result dw 0
   prompt db 'Inserisci numero in formato stringa: $'
   fine db 10 , 13, 'Il risultato in numero decimale si trova nella variabile result o in AX$'
   input db 6       ; 6 - 1 = 5 byte (Numero inseribile fino a 65535)
   

.code                                                                                        
main proc
; Caricamento data segment
   mov ax , @data
   mov ds , ax

; Stampa prompt
   mov ah , 09h
   lea dx , prompt
   int 21h
; Richiesta input
   mov ah , 0ah
   lea dx , input
   int 21h 
; Stampa finale
      mov ah , 9h    
      lea dx , fine
      int 21h
   
   call GETINT

; Procedura per la conversione del numero necessita numero come ascii in "input" e una variabile di appoggio da una word "result" 
GETINT proc 
; Setup ciclo
   lea si , input + 2
   xor ah , ah
   mov bx , 10
   
   convert_loop:
      xor ah , ah
      mov al, [si]          ; Carica il carattere in al
      cmp al, 0dh           ; Controllo con terminatore a capo
      je done               ; Uscita dal ciclo
      
      sub al, '0'           ; Converte da ascii a numero
      mov cx, ax            ; Salva il numero corrente in cx
      mov ax, result        ; Carica il risultato semi definitivo in ax
      mul bx                ; ax = ax * 10 (sposta a sinistra le cifre)
      add ax, cx            ; Somma il nuovo numero come unità
      mov result, ax        ; Salva il nuovo risultato

      inc si                ; Passa al prossimo carattere
      jmp convert_loop      ; Continua il ciclo
      
   done:
      mov ax , result       ; Carico il risultato in ax 
      end main
      ret 

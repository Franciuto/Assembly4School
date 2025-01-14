; Francesco Fontanesi 13/01/2025
; Implementa un programma che legge un numero fino a 65535, lo memorizza in una word e lo stampa usando due procedure

.model SMALL
.stack 100h
.data
to_print    db 5, ?, 5 dup('$')
input       db 6
prompt      db 'Inserisci numero: $' 
prompt2     db 10, 13, 'Numero in formato stringa stampabile (to_print): $'
result      dw 0


.code
main proc
; Caricamento data segment
   mov ax , @data
   mov ds , ax

; Prompt e input
   ; Prompt
   mov ah , 9h
   lea dx , prompt
   int 21h
   ; Input
   mov ah , 0ah
   lea dx , input
   int 21h

; Chiamata procedure
   ; Setup str2int
   lea ax , input
   add ax , 2
   ; Call str2int
   call str2int
   
   ; Setup int2str
   lea dx , to_print
   add dx , 2
   xor cl , cl
   
   ; Call int2str
   call int2str
   
; Stampa finale
   mov ah , 9h
   lea dx , prompt2
   int 21h
   
   lea dx , to_print + 1
   int 21h
   jmp fine


; Procedura che ricevendo in ax l'offset della stringa ritorna in ax il numero in essa contenuta in formato decimale
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
   
 ; Procedura che riceve in ax il numero intero e in dx l'offset del buffer dove salvare il numero in formato stringa stampabile
   int2str proc
      mov bx , 10                      ; Salvo il divisore
      mov si , dx                      ; Sposto l'indirizzo della variabile output   
      xor dx , dx
      
      divisione:
         div bx                        ; Divisione tra ax e 10
         push dx                       ; Salvo il quoziente ossia la cifra che mi interessa sullo stack
         xor dx , dx                   ; Resetto per la prossima operazione
         inc cx                        ; Aumento per tenere conto di tutte le cifre pushate
         or ax , ax                    ; Controllo se il quoziente è zero
         jz string_composer            ; Se è zero tutte le cifre sono state pushate (vado alla composizione stringa)
         jmp divisione                 ; Altrimenti continuo a dividere
         
      string_composer:            
         pop dx                        ; Prelevo dallo stack salvando in dx (risalgo lo stack)
         add dl , '0'                  ; Converto in ascii
         mov [si] , dl                 ; Aggiungo in stringa
         inc si
      loop string_composer
      mov result, dx 
      ret           
   endp int2str 

fine:
endp main

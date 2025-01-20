; Francesco Fontanesi XX/XX/XX
; Consegna

.model SMALL
.stack 100h
.data   
   raw_input   db       6, ?, dup('$')
   strReq      db       "Inserire il numero di casuali da generare: $"      
   randNum     dw       ?
   n           dw       0
   result      dw       0
   
.code
main proc
; Caricamento data segment
   mov ax , @data
   mov ds , ax

; INPUT REQUEST   
   ; Prompt input
      lea dx , strReq
      mov ah , 09h
      int 21h 
   ; Input
      lea dx , raw_input
      mov ah , 0ah
      int 21h
   ; getInt call
      lea ax , raw_input + 2 
      call str2int
      mov n , ax 
   
   
   
; getInt   
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

end main
ret 

; Francesco Fontanesi 05/01/2025

; Calcola il costo di un viaggio (km × costo/km)
; i viaggi massimi con un budget (budget ÷ costo viaggio)
; il residuo del budget (budget % costo viaggio).

; I dati devono essere messi in input

.model small
.stack 100h
.data                                 
   distance             dw 0          ; Distanza viaggio (Km)          REQUIRED INPUT      
   cost_per_km          dw 0          ; Costo per chilometro           REQUIRED INPUT              
   budget               dw 0          ; Budget totale disponibile      REQUIRED INPUT           
   cost_per_trip        dw 0          ; Costo totale viaggio
   max_trips            dw 0          ; Numero viaggi massimi
   remaining_budget     dw 0          ; Residuo del budget
; Stringhe Input
   input_distance       db 'Inserisci distanza in Km: $'
   input_costkm         db 10, 13, 'Inserisci costo per Km: $'
   input_budget         db 10, 13, 'Inserisci budget: $'
; Stringhe output
   available_budget     db 10, 13, 10, 13, 'Budget disponibile: $'
   budget_left          db 10, 13, 'Budget residuo: $'
   travel_cost          db 10, 13, 'Costo per viaggio: $'
   max_travels          db 10, 13, 'Viaggi massimi: $'
   result               dw 0          ; Variabile appoggio per procedura GETINT  
   input                db 6          ; Variabile generale per input                                 
    
.code
main proc
; Caricamento data segment
      mov ax , @data
      mov ds , ax
 
 
; RICHIESTA DATI      
; Richiesta dati distanza
      ; Scrittura prompt
      mov ah , 9h             
      lea dx , input_distance       
      int 21h
      ; Richiesta input
      mov ah , 0ah           
      lea dx , input                  ; Prendo l'input e lo salvo nella variabile comune per la procedura 
      int 21h
      call getint                     ; Chiamo la procedura
      mov bx , result                 ; Sposto il risultato in AX
      mov distance , bx               ; Poi dentro distance
      mov result , 0                  ; Reset result  
; Richiesta dati cost_per_km
      ; Scrittura prompt
      mov ah , 9h             
      lea dx , input_costkm       
      int 21h
      ; Richiesta input
      mov ah , 0ah           
      lea dx , input                  ; Prendo l'input e lo salvo nella variabile comune per la procedura 
      int 21h
      call getint                     ; Chiamo la procedura
      mov bx , result                 ; Sposto il risultato in AX
      mov cost_per_km , bx            ; Poi dentro distance
      mov result , 0                  ; Reset result    
; Richiesta dati budget
      ; Scrittura prompt
      mov ah , 9h             
      lea dx , input_budget       
      int 21h
      ; Richiesta input
      mov ah , 0ah           
      lea dx , input                  ; Prendo l'input e lo salvo nella variabile comune per la procedura 
      int 21h
      call getint                     ; Chiamo la procedura
      mov bx , result                 ; Sposto il risultato in AX
      mov budget , bx                 ; Poi dentro distance
      mov result , 0                  ; Reset result


; CALCOLO RISULTATI
; Calcolo costo per viaggio (cost_per_trip = distance * cost_per_km)
      mov ax , distance               ; Carico la distanza in ax (Operando 1 moltiplicazione)
      mov bx , cost_per_km            ; Carico il costo per km in bx (Operando 2 moltiplicazione)
      mul bx                          ; Ax = distance * cost_per_km
      mov cost_per_trip , ax
; Numero massimo di viaggi (max_trips = budget / cost_per_trip)
      mov ax , budget                 ; Carica il budget in Ax
      mov bx , cost_per_trip          ; Carica il costo per il viaggio in Bx
      div bx                          ; AX = budget / cost_per_trip, DX = resto
      mov max_trips , ax              ; Salva il numero massimo di viaggi
      mov remaining_budget , dx       ; Salva il budget residuo 
 
 
; STAMPA DEI RISULTATI
      ; Stampa "Budget disponibile: "
      mov ah , 9h
      lea dx , available_budget       ; Stampa stringa
      int 21h
      mov ax , budget                 ; Carica costo per il viaggio
      call stampa_numero              ; Chiamo la procedura per convertire e stampare
      
      ; Stampa "Costo per il viaggio"
      mov ah , 9h
      lea dx , travel_cost            ; Stampa stringa
      int 21h
      mov ax , cost_per_trip          ; Carico risultato dell'operazione (Riga 22)
      call stampa_numero              ; Chiamo la procedura per convertire e stampare
      
      ; Stampa "Viaggi massimi"
      mov ah , 9h
      lea dx , max_travels            ; Stampa stringa
      int 21h
      mov ax , max_trips              ; Carico risultato dell'operazione (Riga 28)
      call stampa_numero              ; Chiamo la procedura per convertire e stampare
      
      ; Stampa "Budget residuo"
      mov ah , 9h
      lea dx , budget_left            ; Stampa stringa
      int 21h
      mov ax , remaining_budget       ; Carico risultato dell'operazione (Riga 28)
      call stampa_numero              ; Chiamo la procedura per convertire e stampare


; PROCEDURE      
; La procedura "GETINT" prende il contenuto ascii della variabile input e lo trasporta in decimale unsigned nella variabile result
GETINT proc 
; Setup ciclo
   lea si , input + 2
   xor ah , ah
   mov bx , 10
   
   convert_loop:
      xor ah , ah                     
      mov al, [si]                    ; Carica il carattere in al
      cmp al, 0dh                     ; Controllo con terminatore a capo
      je done                         ; Uscita dal ciclo
      
      sub al, '0'                     ; Converte da ascii a numero
      mov cx, ax                      ; Salva il numero corrente in cx
      mov ax, result                  ; Carica il risultato semi definitivo in ax
      mul bx                          ; ax = ax * 10 (sposta a sinistra le cifre)
      add ax, cx                      ; Somma il nuovo numero come unità
      mov result, ax                  ; Salva il nuovo risultato

      inc si                          ; Passa al prossimo carattere
      jmp convert_loop                ; Continua il ciclo

; Procedura che converte il numero PRESENTE IN AX in modo da stamparlo correttamente
STAMPA_NUMERO proc                    
   xor dx , dx                        ; Pulizia registri
   xor cx , cx                        ; Pulizia registri
   mov bx , 10                        ; Divisore per dividere decine e unità
   
   divisione:
      div bx                          ; Divisione tra Ax e 10
      push dx                         ; Salvo il quoziente (cifra che mi interessa) sullo stack
      xor dx , dx                     ; Resetto per la prossima operazione
      inc cx                          ; Aumento cx per tenere conto di quante cifre sono state pushate
      or ax , ax                      ; Controllo se il quoziente è 0
      jz stampa                       ; Se è zero e quindi tutte le cifre sono state convertite vado alla stampa
      jmp divisione                   ; Altrimenti continuo a dividere 
      
   stampa:
      pop dx                          ; Prelevo dallo stack salvando in dx (risalgo lo stack)
      add dl , '0'                    ; Converto in ascii
      mov ah , 2h
      int 21h                         ; Stampo dl (la cifra)
      loop stampa                     ; Dato che cx contiene quante cifre sono state convertite finchè non è 0 (tutte sono stampate) continua 
      ret
   stampa_numero endp

done:
   ret

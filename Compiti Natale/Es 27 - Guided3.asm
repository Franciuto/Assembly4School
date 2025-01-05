; Francesco Fontanesi 05/01/2025

; Calcola il costo di un viaggio (km × costo/km)
; i viaggi massimi con un budget (budget ÷ costo viaggio)
; il residuo del budget (budget % costo viaggio).

.model small
.stack 100h
.data                                            
   distance             dw 250      ; Distanza viaggio (Km)
   cost_per_km          dw 3        ; Costo per chilometro
   budget               dw 1000     ; Budget totale disponibile
   cost_per_trip        dw 0        ; Costo totale viaggio
   max_trips            dw 0        ; Numero viaggi massimi
   remaining_budget     dw 0        ; Residuo del budget
; Stringhe
   available_budget     db 'Budget disponibile: $'
   budget_left          db 10, 13, 'Budget residuo: $'
   travel_cost          db 10, 13, 'Costo per viaggio: $'
   max_travels          db 10, 13, 'Viaggi massimi: $'
      
.code
main proc
; Caricamento data segment
      mov ax , @data
      mov ds , ax
     
; Calcolo costo per viaggio (cost_per_trip = distance * cost_per_km)
      mov ax , distance                ; Carico la distanza in ax (Operando 1 moltiplicazione)
      mov bx , cost_per_km             ; Carico il costo per km in bx (Operando 2 moltiplicazione)
      mul bx                           ; Ax = distance * cost_per_km
      mov cost_per_trip , ax
      
; Numero massimo di viaggi (max_trips = budget / cost_per_trip)
      mov ax , budget                  ; Carica il budget in Ax
      mov bx , cost_per_trip           ; Carica il costo per il viaggio in Bx
      div bx                           ; AX = budget / cost_per_trip, DX = resto
      mov max_trips , ax               ; Salva il numero massimo di viaggi
      mov remaining_budget , dx        ; Salva il budget residuo 
   
; Stampa dei risultati
      ; Stampa "Budget disponibile: "
      mov ah , 9h
      lea dx , available_budget        ; Stampa stringa
      int 21h
      mov ax , budget                  ; Carica costo per il viaggio
      call stampa_numero               ; Chiamo la procedura per convertire e stampare
      
      ; Stampa "Costo per il viaggio"
      mov ah , 9h
      lea dx , travel_cost             ; Stampa stringa
      int 21h
      mov ax , cost_per_trip           ; Carico risultato dell'operazione (Riga 22)
      call stampa_numero               ; Chiamo la procedura per convertire e stampare
      
      ; Stampa "Viaggi massimi"
      mov ah , 9h
      lea dx , max_travels             ; Stampa stringa
      int 21h
      mov ax , max_trips               ; Carico risultato dell'operazione (Riga 28)
      call stampa_numero               ; Chiamo la procedura per convertire e stampare
      
      ; Stampa "Budget residuo"
      mov ah , 9h
      lea dx , budget_left             ; Stampa stringa
      int 21h
      mov ax , remaining_budget        ; Carico risultato dell'operazione (Riga 28)
      call stampa_numero               ; Chiamo la procedura per convertire e stampare

;Termino il programma
      jmp fine
   
   
; Procedura che converte il numero PRESENTE IN AX in modo da stamparlo correttamente
STAMPA_NUMERO proc
   xor dx , dx                      ; Pulizia registri
   xor cx , cx                      ; Pulizia registri
   mov bx , 10                      ; Divisore per dividere decine e unità
   
   divisione:
      div bx                        ; Divisione tra Ax e 10
      push dx                       ; Salvo il quoziente (cifra che mi interessa) sullo stack
      xor dx , dx                   ; Resetto per la prossima operazione
      inc cx                        ; Aumento cx per tenere conto di quante cifre sono state pushate
      or ax , ax                    ; Controllo se il quoziente è 0
      jz stampa                     ; Se è zero e quindi tutte le cifre sono state convertite vado alla stampa
      jmp divisione                 ; Altrimenti continuo a dividere 
      
   stampa:
      pop dx                        ; Prelevo dallo stack salvando in dx (risalgo lo stack)
      add dl , '0'                  ; Converto in ascii
      mov ah , 2h
      int 21h                       ; Stampo dl (la cifra)
      loop stampa                   ; Dato che cx contiene quante cifre sono state convertite finchè non è 0 (tutte sono stampate) continua 
      ret
   stampa_numero endp

fine:
   end main
   ret   
  

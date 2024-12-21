; Francesco Fontanesi 18/11/2024
;Stampare il codice ASCII Esteso, in modo che per ogni carattere cambino colore in primo piano e background. 

;REGISTRI						TABELLA COLORI                                                      
;+----+----+                    +----------------+--------------------+
;| AH | AL |                    |     Colore     | Codice esadecimale |
;+----+----+                    +----------------+--------------------+
;| BH | BL |                    |      Nero      |         0          |
;+----+----+                    |      Blu       |         1          |
;| CH | CL |                    |     Verde      |         2          |
;+----+----+                    |    Azzurro     |         3          |
;| DH | DL |                    |     Rosso      |         4          |
;+----+----+                    |    Magenta     |         5          |
;| SI      |                    |    Marrone     |         6          |
;+---------+                    | Grigio chiaro  |         7          |
;| DI      |                    |  Grigio scuro  |         8          |
;+---------+                    |   Blu chiaro   |         9          |
;| BP      |                    |  Verde chiaro  |         A          |
;+---------+                    | Azzurro chiaro |         B          |
;| SP      |                    |  Rosso chiaro  |         C          |
;+---------+                    | Magenta chiaro |         D          |
;                               |     Giallo     |         E          |
;                               |     Bianco     |         F          |
;                               +----------------+--------------------+

;REGISTRI PER SCRITTURA SCHERMO
;0 1 2 3 4 5 6 ................................ 154 155 156 157 158 159
;160 161 162 163 .............................. 314 315 316 317 318 319
;1920 1921 .................. 2000 2001 ..................... 2078 2079
;3840 3841 3842 3843 .............................. 3996 3997 3998 3999




;Setup registri per utilizzo memoria video
mov ax , 0B800h 		
mov es , ax 

mov cl , 255        ;Setup counter del ciclo a 255 in modo da stampare tutti i valori dell'ASCII esteso 
mov bl , 2          ;Setup del registro che indica il FOREGROUND a 2 in modo da non trovarsi nella situazione dove BG e FG sono uguali non vedendo il carattere stampato
mov al , 1          ;Setup del registro bh tramite al (Background)


ripetizione:
       
inc dl              ;Incremento dl per scrivere i caratteri ASCII in ordine crescente
mov es:[si] , dl	;Spostamento del carattere da stampare nella memoria video	

mov al , bh         ;Salvataggio su bh il valore salvato in al in modo da evitare che lo scorrimento tra gli sfondi sia interrotto dall'unione con i colori del foreground
shl bh , 4          ;Nel registro bh si spostano i 4 bit presenti di 4 bit verso sinistra in modo da portarli nella parte alta del numero binario in 8 bit per poter fare spazio alla loro sinistra ai 4 bit riservati al foreground
or bh , bl          ;Unione i due registri e otterrò: 4 bit per background - 4 bit foreground
inc si              ;Spostamento nella memoria video
mov es:[si] , bh    ;Formattazione del testo attraverso il registro bh preparato appositamente
inc si	            ;Spostamento nella memoria video
inc al              ;Incremento del registro al che contiene il vero valore dello scorrimento dei colori del background
mov bh , al         ;Aggiornamento del registro bh con i valori corretti per lo sfondo salvati in al
inc bl              ;Incremento di bl per passare al foreground successivo (che invece non è stato toccato)

loop ripetizione

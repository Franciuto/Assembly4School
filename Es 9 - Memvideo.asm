; Francesco Fontanesi 03/10/2024

;  Eseguire e studiare il sorgente in allegato, Scrivere modificarlo in modo che:
;   a. scriva il vostro nome nell'angolo in alto a sinistra in bianco su nero
;   b. scriva il vostro cognome nell'angolo in basso a destra distanziando ogni carattere con uno spazio e in modo che ogni lettera sia di un colore diverso
;   c. scriva la vostra data di nascita al centro dello schermo in multicolor e lampeggiante (dovrete scoprire come si fa).
 
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




;Setup registri
mov ax , 0B800h 			;Impostazione del segmento ax per sezione memoria video
mov es , ax 				;Setup segmento ES per indirizzamento prima parte memoria video

;Blocco per scrittura lettera
mov es:[si] , 'F'			;Sposta il valore ASCII corrispondente alla lettera 'f' nel primo segmento di memoria corrispondente a "es" (0b800h) e all'indirizzo specificato da "si" ossia (0000)
inc si						;Incrementa il valore di "si" per scrivere le istruzioni di colore del carattere nella coppia di bit successivo
mov es:[si] , 0Fh			;Salva l'istruzione per colorare il carattere secondo le opzioni di colore indicate in tabella sovrastante
inc si						;Incrementa il valore di "si" per salvare la lettera successiva

;Blocchi uguali al precedente ripetuti per ogni lettera
mov es:[si] , 'r'
inc si
mov es:[si] , 0Fh
inc si
mov es:[si] , 'a'
inc si
mov es:[si] , 0Fh 
inc si
mov es:[si] , 'n'
inc si
mov es:[si] , 0Fh
inc si
mov es:[si] , 'c'
inc si
mov es:[si] , 0Fh
inc si
mov es:[si] , 'e'
inc si
mov es:[si] , 0Fh
inc si
mov es:[si] , 's'
inc si
mov es:[si] , 0Fh
inc si  
mov es:[si] , 'c'
inc si
mov es:[si] , 0Fh
inc si
mov es:[si] , 'o'
inc si
mov es:[si] , 0Fh
inc si

;Setup registri
mov si , 3999 			;Imposto il registro "si" a 3999 perchè corrisponde all'ultimo indirizzo utilizzabile in memoria per scrivere quindi in posizione basso a destra
						;Per ogni lettera che si vuole scrivere è necessario utilizzare due indirizzi di memoria (4 bit) 2 per la lettera e 2 per l'attributo
						;i dati devono essere inseriti in memoria rispettando la "funzione" degli indirizzi (in 3999 per esempio deve essere salvato il formato
						;colore della lettera, quindi in 3998 dovrò salvare per forza la lettera da stampare) e così via
sub si , 33 			;Secondo questo principio vado a calcolare gli indirizzi di memoria necessari per scrivere il mio cognome
						;essendo composto da 9 cifre dovrei aver bisogno di: (9 * 2 = 18 | 18 - 1 = 17 perchè l'ultimo indirizzo è di formato quindi avrei uno spazio vuoto)
						;dovendo però distanziare ogni lettera di 1 devo aggiungere due registri, uno per il carattere di spazio e uno per il suo formato
						
						
           
mov es:[si] , 'F'		;Sposta il valore ASCII corrispondente alla lettera 'f' nel primo segmento di memoria corrispondente a "es" (0b800h) e all'indirizzo specificato da "si" ossia (3966)		
inc si					;Incrementa si per andare verso l'angolo a destra
mov es:[si] , 0Fh		;Formato colore per il carattere secondo la tabella
inc si
mov es:[si] , 10		;Aggiungo uno spazio tra una lettera e l'altra
inc si
mov es:[si] , 00h		;Formato per lo spazio


;Blocchi uguali al precedente ripetuti per ogni lettera
inc si
mov es:[si] , 'o'
inc si
mov es:[si] , 0eh
inc si
mov es:[si] , 10
inc si
mov es:[si] , 00h
inc si
mov es:[si] , 'n'
inc si
mov es:[si] , 02h
inc si
mov es:[si] , 10
inc si
mov es:[si] , 00h
inc si
mov es:[si] , 't'
inc si
mov es:[si] , 0ch
inc si
mov es:[si] , 10
inc si
mov es:[si] , 00h
inc si
mov es:[si] , 'a'
inc si
mov es:[si] , 03h
inc si
mov es:[si] , 10
inc si
mov es:[si] , 00h
inc si
mov es:[si] , 'n'
inc si
mov es:[si] , 04h
inc si
mov es:[si] , 10
inc si
mov es:[si] , 00h
inc si
mov es:[si] , 'e'
inc si
mov es:[si] , 05h
inc si
mov es:[si] , 10
inc si
mov es:[si] , 00h
inc si
mov es:[si] , 's'
inc si
mov es:[si] , 06h
inc si
mov es:[si] , 10
inc si
mov es:[si] , 00h
inc si 
mov es:[si] , 'i'
inc si
mov es:[si] , 0ah
inc si
 
;Setup registri
mov si , 1990 		;Il carattere centrale dello schermo corrisponde a 2000 (vedi inizio) quindi dato che "07/04/2008"
					;sono 10 caratteri e servono 2 registri per carattere 10 * 2 = 20 
					;ma per mantenere il testo centrato 20 / 2 = 10 quindi avrò 10 caratteri prima di 2000 e 10 dopo
					;2000 - 10 = 1990 per questo lo imposto a 1990 
					
					

mov es:[si] , '0' 	;Sposta il valore ASCII corrispondente alla lettera '0' nel primo segmento di memoria corrispondente a "es" (0b800h) e all'indirizzo specificato da "si" ossia (1990)		
inc si				;Incremento si per andare verso destra
mov es:[si] , 0Fh	;Formato del carattere (bianco)
inc si

;Stesse istruzioni ripetute	
mov es:[si] , '7'
inc si
mov es:[si] , 0Fh
inc si
mov es:[si] , '/'
inc si
mov es:[si] , 0Fh
inc si 
mov es:[si] , '0'
inc si
mov es:[si] , 0Fh
inc si
mov es:[si] , '4'
inc si
mov es:[si] , 0Fh
inc si
mov es:[si] , '/'
inc si
mov es:[si] , 0Fh
inc si
mov es:[si] , '2'
inc si
mov es:[si] , 0Fh
inc si
mov es:[si] , '0'
inc si
mov es:[si] , 0Fh
inc si
mov es:[si] , '0'
inc si
mov es:[si] , 0Fh
inc si
mov es:[si] , '8'
inc si
mov es:[si] , 0Fh
inc si           







 


 
ret

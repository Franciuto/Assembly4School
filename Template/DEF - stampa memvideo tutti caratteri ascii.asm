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
mov ax , 0B800h 		
mov es , ax 

mov cl , 255

mov bl , 0      ;FOREGROUND
mov bh , 0      ;BACKGROUND
; AH =====> Main


ripetizione:

inc dl
mov es:[si] , dl		
inc bh
shl bh , 4
inc bl
or bh , bl
inc si
mov es:[si] , bh
inc si	           

loop ripetizione
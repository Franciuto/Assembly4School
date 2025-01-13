# Assembly4School

Questa directory contiene una serie di esercizi in assembly per il microprocessore 8086. Gli esercizi esplorano vari aspetti della programmazione a basso livello, come la gestione della memoria e la manipolazione dei caratteri.

## Indice Esercizi

#### [Es. 01 - Nome](./Es%2001%20-%20Nome.asm)
Scrivere un programma che stampa una serie di caratteri in modo da comporre il proprio nome.

#### [Es. 02 - Somma](./Es%2002%20-%20Somma.asm)
Scrivere un programma che, dati in input due numeri, calcoli e stampi la loro somma.

#### [Es. 03 - PrecedenteSuccessivo](./Es%2003%20-%20PrecedenteSuccessivo.asm)
Scrivere un programma che, data una lettera in input, stampi la lettera precedente e quella successiva.

#### [Es. 04 - Rot2](./Es%2004%20-%20Rot2.asm)
Scrivere un programma che, data una stringa in memoria, la stampi sostituendo ogni lettera con quella aumentata di 2 posizioni nell'alfabeto.

#### [Es. 05 - Cognome](./Es%2005%20-%20Cognome.asm)
Caricare in memoria il proprio cognome, a partire dalla locazione di memoria `0x0200h`.

#### [Es. 06 - ASCII](./Es%2006%20-%20ASCII.asm)
Implementare un programma con Emu8086 che:
1. Popoli le locazioni di memoria, a partire da un indirizzo `0xggmmh`, con i caratteri stampabili del codice ASCII (dove `mm` è il mese di nascita e `gg` è il giorno di nascita).
2. Alla pressione di un tasto qualsiasi, stampi tutti i caratteri salvati, uno per riga.

#### [Es. 07 - Rot13](./Es%2007%20-%20Rot13.asm)
Implementare un programma con Emu8086 che:
1. Riceve in input parole fino a 10 caratteri.
2. Per ogni lettera inserita, stampa accanto la corrispondente traslata di 13 posizioni (ad es. A → N), va a capo e accetta la successiva lettera.

#### [Es. 08 - Countdown](./Es%2008%20-%20Countdown.asm)
Implementare un programma con Emu8086 che consenta di:
1. Inserire una cifra da tastiera.
2. Stampare il conto alla rovescia, a partire dal numero inserito fino a zero.

#### [Es. 09 - Memvideo](./Es%2009%20-%20Memvideo.asm)
Eseguire e studiare il sorgente allegato. Modificarlo per:
1. Scrivere il proprio nome nell'angolo in alto a sinistra in bianco su nero.
2. Scrivere il proprio cognome nell'angolo in basso a destra, distanziando ogni carattere con uno spazio e utilizzando un colore diverso per ogni lettera.
3. Scrivere la propria data di nascita al centro dello schermo in multicolor.

#### [Es. 10 - ASCII Color](./Es%2010%20-%20ASCII%20Color.asm)
Creare un programma che utilizzi i colori per stampare i caratteri ASCII su schermo, variando il colore per ogni carattere.

#### [Es. 11 - Countdown Color](./Es%2011%20-%20Countdown%20Color.asm)
Implementare un programma con Emu8086 che consenta di:
1. Inserire una cifra da tastiera.
2. Stampare il conto alla rovescia, a partire dal numero inserito fino a zero, utilizzando un colore diverso per ogni numero.

#### [Es. 12 - Windows](./Es%2012%20-%20Windows.asm)
Dati una larghezza `W` e un'altezza `H` salvate in opportune variabili:
1. Disegnare una cornice di dimensione `W x H` caratteri.
2. Consentire di scegliere la posizione in cui disegnarla usando altre due variabili `X` e `Y` che indicano l'angolo superiore sinistro.
3. Utilizzare qualsiasi carattere per il disegno della cornice.

#### [Es. 13 - A Capo](./Es%2013%20-%20A%20Capo.asm)
Data una cifra `N`:
1. Stampare, a capo, la cifra precedente se `N` è minore di 5.
2. Stampare, a capo, la cifra successiva se `N` è maggiore o uguale a 5.

#### [Es. 14 - Asterischi](./Es%2014%20-%20Asterischi.asm)
Dato un numero `N` compreso tra 0 e 9:
1. Stampare una riga di `N` asterischi.
2. Utilizzare colori diversi per ogni asterisco.

#### [Es. 15 - Successive](./Es%2015%20-%20Successive.asm)
Data una lettera `C` e una cifra `N` inserite da tastiera:
1. Stampare gli `N` caratteri successivi alla lettera `C`.

#### [Es. 16 - Capitalize](./Es%2016%20-%20Capitalize.asm)
Dato un carattere minuscolo in input:
1. Stampare la corrispondente lettera maiuscola (qualsiasi altro carattere viene ignorato).
2. Il programma continua a effettuare conversioni e si interrompe solo alla pressione della barra spaziatrice.
3. Stampare un saluto finale prima di terminare.

#### [Es. 17 - Successivi](./Es%2017%20-%20Successivi.asm)
Leggere due caratteri da tastiera e stampare `S` se sono successivi sulla tavola ASCII, `N` altrimenti.

#### [Es. 18 - Tipo Car](./Es%2018%20-%20Tipo%20Car.asm)
Dato un carattere in input:
1. Stampare `C` se è una cifra, `L` se è una lettera, `A` altrimenti.
2. Continuare a richiedere l'input fino all'inserimento del carattere `\`.

#### [Es. 19 - Lessicografico](./Es%2019%20-%20Lessicografico.asm)
Date due lettere inserite da tastiera:
1. Verificare se sono in ordine lessicografico:
   - Stampare `N` in caso negativo.
   - Stampare l'elenco delle lettere comprese in caso positivo.
2. Il programma termina quando le due lettere coincidono, stampando il messaggio "...bye".

#### [Es. 20 - Next4](./Es%2020%20-%20Next4.asm)
Data una lettera da tastiera:
1. Stampare le successive 4 lettere alternando maiuscole e minuscole.

#### [Es. 21 - Stringhe Macro](./Es%2021%20-%20StringheMacro.asm)
Aggiungere la gestione delle maiuscole e completare l'esercizio omonimo (in allegato) correggendo il codice e ricorrendo il più possibile all'uso di stringhe e macro. 

#### [Es. 22 - Commando](Commando/Es%2022%20-%20Commando.asm)
[Consegna](Commando/Consegna.txt)

#### [Es. 23 - Rot13 Strings](./Es%2023%20-%20Rot13Strings.asm)
Richiedere l'immisione di una stringa da tastiera. Codificare il testo immesso con ROT13, badando a rimuovere gli spazi e punteggiature, trasformando tutto in minuscolo e senza alterare le cifre.

#### [Es. 24 - To Upper](./Es%2024%20-%20ToUpper.asm)
Richiedere l'immissione di una stringa con caratteri qualsiasi; a capo, stampare la stringa in caratteri maiuscoli

## [Compiti Natale](Compiti%20Natale)
##### [Es. 25 - Guided 1](Compiti%20Natale/Es%2025%20-%20Guided1.asm)
Data una stringa inserita contenente due cifre convertirla in un numero unsigned di due cifre
##### [Es. 26 - Guided 2](Compiti%20Natale/Es%2026%20-%20Guided2.asm)
Stampa di un numero unsigned a due cifre (hard-coded)
##### [Es. 27 - Guided 3](Compiti%20Natale/Es%2027%20-%20Guided3.asm)
Esercizio di calcolo viaggi fattibili

##### [Es. 28 - Calcolatrice Basic](Compiti%20Natale/Es%2028%20-%20Calcolatrice%20Basic.asm)
Creazione calcolatrice che accetta operandi mono-cifra interi e restituisce il risultato
##### [Es. 29 - Conversione stringa a intero (16bit)](Compiti%20Natale/Es%2029%20-%20String%20to%20Int.asm)
partendo dall’esempio1, estendere la logica del programma in modo che supporti numeri fino a 255 ancora meglio sarebbe fino a 65535
##### [Es. 30 - Stampa Numeri 16 Bit](Compiti%20Natale/Es%2030%20-%20StampaNumeri%2016Bit.asm)
Partendo dall’esempio2, estendere la logica del programma in modo che supporti numeri a 8bit e stampi numeri fino a 255 (per i più ardimentosi numeri fino a 65535).
##### [Es. 31 - Stampa Numeri 16 Bit con procedura](Compiti%20Natale/Es%2031%20-%20StampaNumeri%2016Bit%20proc.asm)
Implementare una procedura che stampa a schermo il numero a più cifre passato attraverso AX
##### [Es. 32 - Conversione stringa procedura (16bit)](Compiti%20Natale/Es%2032%20-%20String%20to%20Int%20Procedura.asm)
Utilizzo di una procedura per estrarre il numero decimale unisgned a 16 bit massimo da una stringa e salvarlo in AX
##### [Es. 33 - Transporter](Compiti%20Natale/Es%2033%20-%20Transporter.asm)
Esercizio di calcolo viaggi fattibili (Es 27) con input implementato

---

##### [Es. 34 - Inverti stringa stack](/Es%2034%20-%20invert_stack.asm)
Stampare la stringa richiesta in input invertita usando lo stack
##### [Es. 35 - Inverti stringa buffer](/Es%2035%20-%20invert_buffer.asm)
Stampare la stringa richiesta in input invertita usando lo stack

---
#### File template
[COM Template](Templates/0_com_template.txt)

[EXE Template](Templates/1_exe_template.txt)

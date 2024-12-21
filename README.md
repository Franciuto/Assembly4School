# Getting Started with Memory

Questa directory contiene una serie di esercizi in assembly per il microprocessore 8086. Gli esercizi esplorano vari aspetti della programmazione a basso livello, come la gestione della memoria e la manipolazione dei caratteri.

## Indice Esercizi

### [Es. 1 - Nome](Es%201%20-%20Nome.asm)
Scrivere un programma che stampa una serie di caratteri in modo da comporre il proprio nome.

### [Es. 2 - Somma](Es%202%20-%20Somma.asm)
Scrivere un programma che, dati in input due numeri, calcoli e stampi la loro somma.

### [Es. 3 - Precedente e Successivo](Es%203%20-%20PrecedenteSuccessivo.asm)
Scrivere un programma che, data una lettera in input, stampi la lettera precedente e quella successiva.

### [Es. 4 - Rot2](Es%204%20-%20Rot2.asm)
Scrivere un programma che, data una stringa in memoria, la stampi sostituendo ogni lettera con quella aumentata di 2 posizioni nell'alfabeto.

### [Es. 5 - Cognome](Es%205%20-%20Cognome.asm)
Caricare in memoria il proprio cognome, a partire dalla locazione di memoria `0x0200h`.

### [Es. 6 - ASCII](Es%206%20-%20ASCII.asm)
Implementare un programma con Emu8086 che:
1. Popoli le locazioni di memoria, a partire da un indirizzo `0xggmmh`, con i caratteri stampabili del codice ASCII (dove `mm` è il mese di nascita e `gg` è il giorno di nascita).
2. Alla pressione di un tasto qualsiasi, stampi tutti i caratteri salvati, uno per riga.

### [Es. 7 - ROT13](Es%207%20-%20ROT13.asm)
Implementare un programma con Emu8086 che:
1. Riceve in input parole fino a 10 caratteri.
2. Per ogni lettera inserita, stampa accanto la corrispondente traslata di 13 posizioni (ad es. A → N), va a capo e accetta la successiva lettera.

### [Es. 8 - Countdown](Es%208%20-%20Countdown.asm)
Implementare un programma con Emu8086 che consenta di:
1. Inserire una cifra da tastiera.
2. Stampare il conto alla rovescia, a partire dal numero inserito fino a zero.

### [Es. 9 - Memvideo](Es%209%20-%20Memvideo.asm)
Eseguire e studiare il sorgente allegato. Modificarlo per:
1. Scrivere il proprio nome nell'angolo in alto a sinistra in bianco su nero.
2. Scrivere il proprio cognome nell'angolo in basso a destra, distanziando ogni carattere con uno spazio e utilizzando un colore diverso per ogni lettera.
3. Scrivere la propria data di nascita al centro dello schermo in multicolor.

### [Es. 10 - ASCII Color](Es%2010%20-%20ASCII%20Color.asm)
Creare un programma che utilizzi i colori per stampare i caratteri ASCII su schermo, variando il colore per ogni carattere.

### [Es. 11 - Countdown Color](Es%2011%20-%20Countdown%20Color.asm)
Implementare un programma con Emu8086 che consenta di:
1. Inserire una cifra da tastiera.
2. Stampare il conto alla rovescia, a partire dal numero inserito fino a zero, utilizzando un colore diverso per ogni numero.

### [Es. 12 - Windows](Es%2012%20-%20Windows.asm)
Dati una larghezza `W` e un'altezza `H` salvate in opportune variabili:
1. Disegnare una cornice di dimensione `W x H` caratteri.
2. Consentire di scegliere la posizione in cui disegnarla usando altre due variabili `X` e `Y` che indicano l'angolo superiore sinistro.
3. Utilizzare qualsiasi carattere per il disegno della cornice.

### [Es. 13 - A Capo](Es%2013%20-%20A%20Capo.asm)
Data una cifra `N`:
1. Stampare, a capo, la cifra precedente se `N` è minore di 5.
2. Stampare, a capo, la cifra successiva se `N` è maggiore o uguale a 5.

### [Es. 14 - Asterischi](Es%2014%20-%20Asterischi.asm)
Dato un numero `N` compreso tra 0 e 9:
1. Stampare una riga di `N` asterischi.
2. Utilizzare colori diversi per ogni asterisco.

### [Es. 15 - Successive](Es%2015%20-%20Successive.asm)
Data una lettera `C` e una cifra `N` inserite da tastiera:
1. Stampare gli `N` caratteri successivi alla lettera `C`.

### [Es. 16 - Capitalize](Es%2016%20-%20Capitalize.asm)
Dato un carattere minuscolo in input:
1. Stampare la corrispondente lettera maiuscola (qualsiasi altro carattere viene ignorato).
2. Il programma continua a effettuare conversioni e si interrompe solo alla pressione della barra spaziatrice.
3. Stampare un saluto finale prima di terminare.

---

Buon lavoro con l'assembly!

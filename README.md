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

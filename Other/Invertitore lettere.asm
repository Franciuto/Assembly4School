org 100h

;Setup lettura
mov AH , 1

;Lettura e salvataggio Valore 1
int 21h
mov BH , AL

;Lettura e salvataggio Valore 2
int 21h
mov BL , AL

;Scambio valore tra i registri
mov BL , BH
mov BH , AL

;Pulizia schermo
mov AH , 00
int 10h 

;Setup scrittura
mov AH , 2

;Scrittura valore 1 (Ex valore 2)

mov DL , BH
int 21h

;Scrittura valore 2 (Ex valore 1)
mov DL , BL
int 21h







ret





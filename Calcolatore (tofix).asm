 ;Setup Lettura
mov AH , 1

;Lettura cifra 1
int 21h
sub AL, 30h
mov DL , AL

;Lettura cifra 2
int 21h
sub AL, 30h 
mov CL , AL  
   
;Somma
add DL , CL

;Conversione ASCII
add DL , 30h
         
;Pulizia schermo
mov AH , 00
int 10h 

;Setup Scrittura  
mov AH, 2

;Scrittura
int 21h 


ret
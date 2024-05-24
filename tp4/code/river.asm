MOVB AL, 0x0002    ; ancho de cada línea horizontal que conforma la franja es de longitud 2
MOVB BH, 0x03
MOVB CH, 0x00

Secuencia2:        ; bucle para dibujar la franja diagonal
MOVB CL, 0x00      ; pinta de blanco
MOVB [B], 0x0C4    ; pinta de rojo
CMPB BL, 255       ; comprueba el fin de la pantalla
JZ Fin             ; termina el programa
INCB BL            ; incrementa BL para movernos horizontalmente
CMPB BL, 240       
JZ Salto2          
INCB AL            ; incrementa el ancho de la franja
CMPB AL, 0x0005    ; compara el ancho de franja con 5 (longitud deseada)
JZ Secuencia1      ; si es 5 debe reiniciarse el ancho de la franja
JMP Secuencia2


Secuencia1:        ; reinicia el grosor de la franja
MOVB AL, 0x00      ; reinicia AL a 0 para comenzar una nueva franja
INCB BL         
CMPB BL, 0x000F    ; 15 es un posible límite horizontal
JZ Salto1          
INCB CL            ; controla la posición vertical
CMPB CL, 0x000C    ; comparar CL con 12 un límite vertical específico
JZ Secuencia2      ; si CL es 12, salta de nuevo a Secuencia2 para comenzar una nueva iteración
JMP Secuencia1     

Salto2:            ; controla de desplazamiento horizontal
INCB BL            
JMP Secuencia1     

Salto1:            ; ajusta el desplazamiento horizontal y grosor
INCB BL            
INCB AL            
MOVB [B], 0x00     ; establece el color blanco
JMP Secuencia2     ; salta a Secuencia2 para continuar el dibujo

Fin:
HLT                ; finaliza el programa
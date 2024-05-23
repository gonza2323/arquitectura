;Cuadro De Ajedrez
	MOVB AL,0x0002
	MOVB BH,0x03
	MOVB CH,0x00
Secuencia2:
	MOVB CL,0x00
	MOVB [B],0x0C4
	CMPB BL,255
	JZ Fin
	INCB BL
	CMPB BL,240
	JZ Salto2
	INCB AL
	CMPB AL,0x0005
	JZ Secuencia1
	JMP Secuencia2
Secuencia1:
	MOVB AL,0x00
	INCB BL
	CMPB BL,0x000F
	JZ Salto1
	INCB CL
	CMPB CL,0x000C
	JZ Secuencia2
	JMP Secuencia1
Salto2:
	INCB BL
	JMP Secuencia1
Salto1:
	INCB BL
	INCB AL
	MOVB [B],0x00
	JMP Secuencia2
Fin:
	HLT
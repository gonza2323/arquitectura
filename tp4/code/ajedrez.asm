ScrStart  EQU 0x0300 ; Comienzo de la pantalla
ScrEnd    EQU 0x0400 ; Fin de la pantalla
KeyStatus EQU 0x0005 ; Registro de estado del teclado
KeyData   EQU 0x0006 ; Registro de botón presionada

Input:              ; Loop que realiza el polling de los botones
    IN KeyStatus    ; Estado del teclado a registro A
    CMP A, 0
    JZ Input        ; Si se presionó, seguimos, si no, volvemos a 'Input'
    MOV D, ScrStart ; Dirección de la pantalla al registro D
    IN KeyData      ; Botón presionado al registro A
    CMP A, 0x032    ; Comparamos con el carácter ASCII de '2'
    JZ Print        ; Si es '2', saltamos a la subrutina 'Print'
    CMP A, 0x031    ; Comparamos con el carácter ASCII de '1'
    JZ Clear        ; Si es '1', saltamos a la subrutina 'Clear'
    JMP Input       ; De otra forma, volvemos al loop de 'Input'

Clear:              ; Subrutina para borrar el tablero
    MOVB [D], 0xFF  ; Pintamos de blanco el pixel actual
    INC D           ; Incrementamos el puntero
    CMP D, ScrEnd   ; Verificar si llegamos al final
    JZ Input        ; Si es así, volver a 'Input'
    JMP Clear       ; Si no, volvemos a 'Clear' para seguir borrando
Print:              ; Subrutina que dibuja el tablero
    MOVB AL, 0      ; Color inicial a A
Row:                ; Loop de las 'filas' de 32 píxeles
    MOV B, 32       ; 32 al registro B
    NOTB AL         ; Invertimos el color
Square:             ; Loop de los 'cuadro' de 2 píxeles
    MOV C, 2        ; 2 al registro C
    NOTB AL         ; Invertimos el color
Pixel:              ; Loop para pintar píxeles
    MOVB [D], AL    ; Pintamos el pixel actual con el color actual
    INC D           ; Incrementamos el puntero
    CMP D, ScrEnd   ; Verificar si llegamos al final
    JZ Input        ; Si es así, volver a 'Input'
    DEC B           ; Decrementamos contador de 'fila'
    JZ Row          ; Si terminó la fila, volvemos a 'Row'
    DEC C           ; Decrementamos contador de 'cuadro'
    JZ Square       ; Si terminó el cuadro, volvemos a 'Square'
    JMP Pixel       ; Volver a 'Pixel'
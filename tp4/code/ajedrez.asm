Pulsador:           ; Subrutina que realiza el polling de los botones
    IN 6            ; Cargamos el registro con el botón presionado
    MOV B,0x300     ; Cargamos en el resgistro B la dirección de la pantalla
    CMP A,0x032     ; Lo comparamos con el carácter ASCII de '2'
    JZ Print        ; Si es '2', saltamos a la subrutina 'Print'
    CMP A,0x031     ; Lo comparamos con el carácter ASCII de '1'
    JZ Borrar       ; Si es '1', saltamos a la subrutina 'Borrar'
    JMP             ; De otra forma, volvemos al loop del pulsador

Borrar:             ; Subrutina para borrar el tablero
    INC B           ; Incrementamos el puntero de los píxeles
    MOVB [B],0xFF   ; Movemos el color blanco a ese pixel
      CMP B,0x03FF  ; Verificamos si llegamos al último pixel
    JZ Pulsador     ; Si es así, volvemos al loop del pulsador
    JMP Borrar      ; Si no, volvemos a 'Borrar' para seguir borrando

Print:
    MOVB CL,0x00    ; Cargamos 0 en el registro CL
Bl:
    MOVB DL,0x00    ; Cargamos 0 en el registro DL
Blanco:
    INC B           ; Incrementamos el puntero de los píxeles
    CMP B,0x03FF    ; Verificamos si llegamos al último pixel.
    JZ Pulsador     ; Si es así, volvemos al loop del pulsador
    INCB CL         ; Si no, incrementamos CL
    INCB DL         ; Incrementamos DL
    CMPB CL,0x0002  ; Comparamos CL con '2'
     JZ Salto2      ; Si es así, vamos a 'Salto2'
    JMP Blanco      ; si no, a 'Blanco'
Ng:
    MOVB DL,0x00
Negro:
    MOVB [B],0x00
    INC B
    CMP B,0x03FF
    JZ Pulsador
    INCB CL
    INCB DL
    CMPB CL,0x0002
    JZ Salto1
    JMP Negro
Salto1:
    MOVB CL,0x00
    CMPB DL,0x0020
    JZ Ng
    JMP Blanco
Salto2:
    MOVB CL,0x00    ; Reiniciamos el contador C
    CMPB DL,0x0020  ; Comparamos D con 32
    JZ Bl           ; Si llegamos a 32, saltamos a 'Bl' para pintar con negro
    JMP Negro
    
    HLT
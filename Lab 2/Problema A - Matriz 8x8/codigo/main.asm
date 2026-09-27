; PROBLEMA A

.include "m328pdef.inc"

.equ UBRR_VAL = 103
.equ FRAME_COUNT = 83
.equ SPEED_INIT = 18
.equ SPEED_MIN = 4
.equ SPEED_MAX = 45

.def temp = r16
.def temp2 = r17
.def fila = r18
.def patron = r19
.def tecla = r20
.def offl = r24
.def offh = r25

.dseg
modo:       .byte 1
velocidad:  .byte 1
contador:   .byte 1
cuadro:     .byte 1

.cseg
.org 0x0000
    rjmp reset
;-------------
; INICIO
;--------------
reset:
    ldi temp, low(RAMEND)
    out SPL, temp
    ldi temp, high(RAMEND)
    out SPH, temp

    call puertos_init
    call uart_init

    ldi temp, 0
    sts modo, temp
    sts contador, temp
    sts cuadro, temp

    ldi temp, SPEED_INIT
    sts velocidad, temp

    call imprimir_menu

principal:
    call barrido
    call actualizar
    rjmp principal
;--------------
; CONFIGURACION
;--------------
puertos_init:
    ; d0 rx, d1 tx, d2 a d7 filas
    ldi temp, 0b11111110
    out DDRD, temp

    ; d8 y d9 filas, d10 a d13 columnas
    ldi temp, 0b00111111
    out DDRB, temp

    ; a0 a a3 columnas
    ldi temp, 0b00001111
    out DDRC, temp

    call apagar_matriz
    ret

uart_init:
    ldi temp, high(UBRR_VAL)
    sts UBRR0H, temp
    ldi temp, low(UBRR_VAL)
    sts UBRR0L, temp

    ldi temp, (1 << RXEN0) | (1 << TXEN0)
    sts UCSR0B, temp

    ldi temp, (1 << UCSZ01) | (1 << UCSZ00)
    sts UCSR0C, temp
    ret
;--------------
; UART
;--------------
uart_tx:
    lds temp2, UCSR0A
    sbrs temp2, UDRE0
    rjmp uart_tx
    sts UDR0, temp
    ret

uart_texto:
    lpm temp, Z+
    cpi temp, 0
    breq uart_texto_fin
    call uart_tx
    rjmp uart_texto
uart_texto_fin:
    ret

leer_uart:
    lds temp, UCSR0A
    sbrs temp, RXC0
    ret

    lds tecla, UDR0

    cpi tecla, '1'
    breq comando_texto
    cpi tecla, '2'
    breq comando_figura1
    cpi tecla, '3'
    breq comando_figura2
    cpi tecla, '4'
    breq comando_figura3
    cpi tecla, '5'
    breq comando_prueba
    cpi tecla, '+'
    breq comando_mas_rapido
    cpi tecla, '-'
    breq comando_mas_lento
    cpi tecla, 'm'
    breq comando_menu
    cpi tecla, 'M'
    breq comando_menu
    ret

comando_texto:
    ldi temp, 0
    sts modo, temp
    sts cuadro, temp
    ret

comando_figura1:
    ldi temp, 1
    sts modo, temp
    ret

comando_figura2:
    ldi temp, 2
    sts modo, temp
    ret

comando_figura3:
    ldi temp, 3
    sts modo, temp
    ret

comando_prueba:
    ldi temp, 4
    sts modo, temp
    ret

comando_mas_rapido:
    lds temp, velocidad
    cpi temp, 9
    brlo velocidad_minima
    subi temp, 5
    sts velocidad, temp
    clr temp2
    sts contador, temp2
    ret

velocidad_minima:
    ldi temp, SPEED_MIN
    sts velocidad, temp
    clr temp2
    sts contador, temp2
    ret

comando_mas_lento:
    lds temp, velocidad
    cpi temp, 41
    brsh velocidad_maxima
    ldi temp2, 5
    add temp, temp2
    sts velocidad, temp
    clr temp2
    sts contador, temp2
    ret

velocidad_maxima:
    ldi temp, SPEED_MAX
    sts velocidad, temp
    clr temp2
    sts contador, temp2
    ret

;--------------
; MATRIZ
;--------------
barrido:
    ldi fila, 0
barrido_loop:
    call cargar_patron
    call mostrar_fila
    call demora_fila
    call leer_uart

    inc fila
    cpi fila, 8
    brlo barrido_loop

    call apagar_matriz
    ret

cargar_patron:
    lds temp, modo
    cpi temp, 0
    breq cargar_texto
    cpi temp, 1
    breq cargar_figura1
    cpi temp, 2
    breq cargar_figura2
    cpi temp, 3
    breq cargar_figura3
    rjmp cargar_prueba

cargar_texto:
    lds offl, cuadro
    clr offh
    lsl offl
    rol offh
    lsl offl
    rol offh
    lsl offl
    rol offh

    ldi ZL, low(2 * cuadros_texto)
    ldi ZH, high(2 * cuadros_texto)
    add ZL, offl
    adc ZH, offh
    add ZL, fila
    clr temp
    adc ZH, temp
    lpm patron, Z
    ret

cargar_figura1:
    ldi ZL, low(2 * figura_corazon)
    ldi ZH, high(2 * figura_corazon)
    rjmp cargar_figura

cargar_figura2:
    ldi ZL, low(2 * figura_cara)
    ldi ZH, high(2 * figura_cara)
    rjmp cargar_figura

cargar_figura3:
    ldi ZL, low(2 * figura_flecha)
    ldi ZH, high(2 * figura_flecha)
    rjmp cargar_figura

cargar_prueba:
    ldi ZL, low(2 * figura_prueba)
    ldi ZH, high(2 * figura_prueba)

cargar_figura:
    add ZL, fila
    clr temp
    adc ZH, temp
    lpm patron, Z
    ret

mostrar_fila:
    call apagar_matriz

    ; columnas c1 a c4 en d13 a d10
    mov temp, patron
    andi temp, 0xF0
    lsr temp
    lsr temp
    ori temp, 0b00000011

    cpi fila, 6
    brne revisar_fila8
    andi temp, 0b11111110
    rjmp sacar_puerto_b

revisar_fila8:
    cpi fila, 7
    brne sacar_puerto_b
    andi temp, 0b11111101

sacar_puerto_b:
    out PORTB, temp

    ; columnas c5 a c8 en a3 a a0
    mov temp, patron
    andi temp, 0x0F
    out PORTC, temp

    ; filas f1 a f6 en d2 a d7
    ldi ZL, low(2 * tabla_filas_d)
    ldi ZH, high(2 * tabla_filas_d)
    add ZL, fila
    clr temp
    adc ZH, temp
    lpm temp2, Z

    in temp, PORTD
    andi temp, 0b00000011
    or temp, temp2
    out PORTD, temp
    ret

apagar_matriz:
    in temp, PORTD
    andi temp, 0b00000011
    ori temp, 0b11111100
    out PORTD, temp

    ldi temp, 0b00000011
    out PORTB, temp

    ldi temp, 0
    out PORTC, temp
    ret

demora_fila:
    ldi temp2, 70
demora_1:
    ldi temp, 80
demora_2:
    dec temp
    brne demora_2
    dec temp2
    brne demora_1
    ret

actualizar:
    lds temp, contador
    inc temp
    lds temp2, velocidad
    cp temp, temp2
    brlo guardar_contador

    clr temp
    sts contador, temp

    lds temp2, modo
    cpi temp2, 0
    brne actualizar_fin

    lds temp2, cuadro
    inc temp2
    cpi temp2, FRAME_COUNT
    brlo guardar_cuadro
    clr temp2

guardar_cuadro:
    sts cuadro, temp2
    ret

guardar_contador:
    sts contador, temp

actualizar_fin:
    ret

imprimir_menu:
    ldi ZL, low(2 * texto_inicio1)
    ldi ZH, high(2 * texto_inicio1)
    call uart_texto
    ldi ZL, low(2 * texto_inicio2)
    ldi ZH, high(2 * texto_inicio2)
    call uart_texto
    ldi ZL, low(2 * texto_inicio3)
    ldi ZH, high(2 * texto_inicio3)
    call uart_texto
    ldi ZL, low(2 * texto_inicio4)
    ldi ZH, high(2 * texto_inicio4)
    call uart_texto
    ldi ZL, low(2 * texto_inicio5)
    ldi ZH, high(2 * texto_inicio5)
    call uart_texto
    ldi ZL, low(2 * texto_inicio6)
    ldi ZH, high(2 * texto_inicio6)
    call uart_texto
    ldi ZL, low(2 * texto_inicio7)
    ldi ZH, high(2 * texto_inicio7)
    call uart_texto
    ldi ZL, low(2 * texto_inicio8)
    ldi ZH, high(2 * texto_inicio8)
    call uart_texto
    ldi ZL, low(2 * texto_inicio9)
    ldi ZH, high(2 * texto_inicio9)
    call uart_texto
    ret


comando_menu:
    call imprimir_menu
    ret

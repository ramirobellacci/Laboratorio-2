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

comando_menu:
    call imprimir_menu
    ret

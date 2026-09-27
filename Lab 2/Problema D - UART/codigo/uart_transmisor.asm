; PROBLEMA D
; transmisor uart con 3 pulsadores
; atmega328p - arduino uno compatible - 16 mhz - 9600 baudios

.include "m328pdef.inc"

.equ UBRR_VAL = 103

.def temp = r16
.def temp2 = r17
.def dato = r18
.def anterior = r19
.def d1 = r20
.def d2 = r21

.cseg
.org 0x0000
    rjmp reset

; INICIO
reset:
    ldi temp, low(RAMEND)
    out SPL, temp
    ldi temp, high(RAMEND)
    out SPH, temp

    call puertos_init
    call uart_init

    ldi anterior, 255
    call imprimir_menu

principal:
    call leer_pulsadores
    cp dato, anterior
    breq principal

    mov anterior, dato
    mov temp, dato
    call uart_tx

    call retardo
    rjmp principal

; CONFIGURACION
puertos_init:
    ; d1 tx, d2 a d4 pulsadores con pull-up
    ldi temp, (1 << PD1)
    out DDRD, temp

    ldi temp, (1 << PD2) | (1 << PD3) | (1 << PD4)
    out PORTD, temp
    ret

uart_init:
    ; El bootloader del Uno puede dejar U2X0 activado.
    clr temp
    sts UCSR0A, temp
    ldi temp, high(UBRR_VAL)
    sts UBRR0H, temp
    ldi temp, low(UBRR_VAL)
    sts UBRR0L, temp

    ldi temp, (1 << TXEN0)
    sts UCSR0B, temp

    ldi temp, (1 << UCSZ01) | (1 << UCSZ00)
    sts UCSR0C, temp
    ret

; UART
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

imprimir_menu:
    ldi ZL, low(2 * texto_1)
    ldi ZH, high(2 * texto_1)
    call uart_texto
    ret

; PULSADORES
leer_pulsadores:
    clr dato
    in temp, PIND

    ; pulsador 1 en d2, bit 0
    sbrc temp, PD2
    rjmp revisar_bit1
    ori dato, 0b00000001

revisar_bit1:
    ; pulsador 2 en d3, bit 1
    sbrc temp, PD3
    rjmp revisar_bit2
    ori dato, 0b00000010

revisar_bit2:
    ; pulsador 3 en d4, bit 2
    sbrc temp, PD4
    ret
    ori dato, 0b00000100
    ret

; RETARDO
retardo:
    ldi d1, 80
retardo_1:
    ldi d2, 255
retardo_2:
    dec d2
    brne retardo_2
    dec d1
    brne retardo_1
    ret

; TEXTOS
texto_1:
    .db 13, 10, "TRANSMISOR UART", 13, 10, 0

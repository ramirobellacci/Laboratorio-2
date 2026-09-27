; PROBLEMA D
; receptor uart con 8 leds indicadores
; atmega328p - arduino uno compatible - 16 mhz - 9600 baudios

.include "m328pdef.inc"

.equ UBRR_VAL = 103

.def temp = r16
.def temp2 = r17
.def dato = r18
.def mascara = r19
.def contador = r20

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
    call imprimir_menu

principal:
    call uart_rx
    cpi dato, 8
    brsh principal

    call mostrar_salida
    rjmp principal

; CONFIGURACION
puertos_init:
    ; d0 rx, d1 tx, d2 a d7 leds
    ldi temp, 0b11111110
    out DDRD, temp

    ; d8 y d9 leds
    ldi temp, 0b00000011
    out DDRB, temp

    clr temp
    out PORTD, temp
    out PORTB, temp
    ret

uart_init:
    ; El bootloader del Uno puede dejar U2X0 activado.
    clr temp
    sts UCSR0A, temp
    ldi temp, high(UBRR_VAL)
    sts UBRR0H, temp
    ldi temp, low(UBRR_VAL)
    sts UBRR0L, temp

    ldi temp, (1 << RXEN0) | (1 << TXEN0)
    sts UCSR0B, temp

    ldi temp, (1 << UCSZ01) | (1 << UCSZ00)
    sts UCSR0C, temp
    ret

; UART
uart_rx:
    lds temp, UCSR0A
    sbrs temp, RXC0
    rjmp uart_rx

    lds dato, UDR0

    ; acepta 0 a 7 binario o ascii
    cpi dato, '0'
    brlo uart_rx_fin
    cpi dato, '8'
    brsh uart_rx_fin
    subi dato, '0'

uart_rx_fin:
    ret

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

; SALIDAS
mostrar_salida:
    ldi mascara, 1
    mov contador, dato

crear_mascara:
    tst contador
    breq mascara_lista
    lsl mascara
    dec contador
    rjmp crear_mascara

mascara_lista:
    ; bits 0 a 5 en d2 a d7
    mov temp, mascara
    lsl temp
    lsl temp
    out PORTD, temp

    ; bits 6 y 7 en d8 y d9
    mov temp, mascara
    lsr temp
    lsr temp
    lsr temp
    lsr temp
    lsr temp
    lsr temp
    andi temp, 0b00000011
    out PORTB, temp
    ret

; TEXTOS
texto_1:
    .db 13, 10, "RECEPTOR UART", 13, 10, 0, 0, 0

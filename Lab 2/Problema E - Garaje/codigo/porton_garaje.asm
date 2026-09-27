; PROBLEMA E
; automatizacion de porton de garaje
; atmega328p - arduino uno compatible - 16 mhz - 9600 baudios

.include "m328pdef.inc"

.equ UBRR_VAL = 103

.equ EST_CERRADA = 0
.equ EST_ABRIENDO = 1
.equ EST_ABIERTA = 2
.equ EST_CERRANDO = 3
.equ EST_DETENIDA = 4

.def temp = r16
.def temp2 = r17
.def estado_reg = r18
.def d1 = r19
.def d2 = r20

.dseg
estado:          .byte 1
estado_anterior: .byte 1
flag_obstaculo:  .byte 1

.cseg
.org 0x0000
    rjmp reset

.org PCI2addr
    rjmp pcint2_isr

.org INT_VECTORS_SIZE

; INICIO
reset:
    ldi temp, low(RAMEND)
    out SPL, temp
    ldi temp, high(RAMEND)
    out SPH, temp

    call puertos_init
    call uart_init
    call interrupcion_init

    clr temp
    sts flag_obstaculo, temp

    ldi temp, 255
    sts estado_anterior, temp

    call estado_inicial
    call imprimir_inicio

    sei

principal:
    call imprimir_estado_si_cambio

    lds estado_reg, estado
    cpi estado_reg, EST_CERRADA
    breq ir_estado_cerrada
    cpi estado_reg, EST_ABRIENDO
    breq ir_estado_abriendo
    cpi estado_reg, EST_ABIERTA
    breq ir_estado_abierta
    cpi estado_reg, EST_CERRANDO
    breq ir_estado_cerrando
    rjmp estado_detenida

ir_estado_cerrada:
    rjmp estado_cerrada
ir_estado_abriendo:
    rjmp estado_abriendo
ir_estado_abierta:
    rjmp estado_abierta
ir_estado_cerrando:
    rjmp estado_cerrando

; CONFIGURACION
puertos_init:
    ; d0 rx, d1 tx, d2 a d6 entradas con pull-up
    ldi temp, (1 << PD1)
    out DDRD, temp

    ldi temp, (1 << PD2) | (1 << PD3) | (1 << PD4) | (1 << PD5) | (1 << PD6)
    out PORTD, temp

    ; d8 abre, d9 cierra, d10 alarma
    ldi temp, (1 << PB0) | (1 << PB1) | (1 << PB2)
    out DDRB, temp

    clr temp
    out PORTB, temp
    ret

uart_init:
    ; Fijar velocidad normal aunque el bootloader haya usado U2X0.
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

interrupcion_init:
    ; obstaculo en d6 usando pcint22
    ldi temp, (1 << PCIE2)
    sts PCICR, temp

    ldi temp, (1 << PCINT22)
    sts PCMSK2, temp

    ldi temp, (1 << PCIF2)
    out PCIFR, temp
    ret

estado_inicial:
    in temp, PIND
    sbrs temp, PD5
    rjmp iniciar_cerrada
    sbrs temp, PD4
    rjmp iniciar_abierta

    ldi temp, EST_DETENIDA
    sts estado, temp
    ret

iniciar_cerrada:
    ldi temp, EST_CERRADA
    sts estado, temp
    ret

iniciar_abierta:
    ldi temp, EST_ABIERTA
    sts estado, temp
    ret

; ESTADOS
estado_cerrada:
    call salidas_paradas

    in temp, PIND
    sbrs temp, PD2
    rjmp pasar_abriendo
    rjmp principal

estado_abriendo:
    call salidas_abriendo
    call revisar_seguridad
    brcc abriendo_sin_obstaculo
    rjmp pasar_detenida
abriendo_sin_obstaculo:

    in temp, PIND
    sbrs temp, PD4
    rjmp pasar_abierta
    sbrs temp, PD3
    rjmp pasar_cerrando
    rjmp principal

estado_abierta:
    call salidas_paradas

    in temp, PIND
    sbrs temp, PD3
    rjmp pasar_cerrando
    rjmp principal

estado_cerrando:
    call salidas_cerrando
    call revisar_seguridad
    brcc cerrando_sin_obstaculo
    rjmp pasar_detenida
cerrando_sin_obstaculo:

    in temp, PIND
    sbrs temp, PD5
    rjmp pasar_cerrada
    sbrs temp, PD2
    rjmp pasar_abriendo
    rjmp principal

estado_detenida:
    call salidas_paradas

    in temp, PIND
    sbrs temp, PD2
    rjmp pasar_abriendo
    sbrs temp, PD3
    rjmp pasar_cerrando
    rjmp principal

pasar_cerrada:
    ldi temp, EST_CERRADA
    sts estado, temp
    call retardo
    rjmp principal

pasar_abriendo:
    clr temp
    sts flag_obstaculo, temp
    ldi temp, EST_ABRIENDO
    sts estado, temp
    call retardo
    rjmp principal

pasar_abierta:
    ldi temp, EST_ABIERTA
    sts estado, temp
    call retardo
    rjmp principal

pasar_cerrando:
    clr temp
    sts flag_obstaculo, temp
    ldi temp, EST_CERRANDO
    sts estado, temp
    call retardo
    rjmp principal

pasar_detenida:
    call salidas_paradas
    clr temp
    sts flag_obstaculo, temp
    call imprimir_obstaculo
    ldi temp, EST_DETENIDA
    sts estado, temp
    call retardo
    rjmp principal

; SEGURIDAD
revisar_seguridad:
    ; Devolver carry=1 ante obstaculo, siempre retornando al llamador.
    lds temp, flag_obstaculo
    cpi temp, 0
    brne seguridad_detectada

    in temp, PIND
    sbrs temp, PD6
    rjmp seguridad_detectada
    clc
    ret
seguridad_detectada:
    sec
    ret

pcint2_isr:
    push temp
    in temp, SREG
    push temp

    in temp, PIND
    sbrc temp, PD6
    rjmp pcint2_fin

    ldi temp, 1
    sts flag_obstaculo, temp

pcint2_fin:
    pop temp
    out SREG, temp
    pop temp
    reti

; SALIDAS
salidas_paradas:
    clr temp
    out PORTB, temp
    ret

salidas_abriendo:
    ldi temp, (1 << PB0) | (1 << PB2)
    out PORTB, temp
    ret

salidas_cerrando:
    ldi temp, (1 << PB1) | (1 << PB2)
    out PORTB, temp
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

imprimir_inicio:
    ldi ZL, low(2 * texto_inicio)
    ldi ZH, high(2 * texto_inicio)
    call uart_texto
    ret

imprimir_estado_si_cambio:
    lds temp, estado
    lds temp2, estado_anterior
    cp temp, temp2
    breq imprimir_estado_fin

    sts estado_anterior, temp

    cpi temp, EST_CERRADA
    breq imprimir_cerrada
    cpi temp, EST_ABRIENDO
    breq imprimir_abriendo
    cpi temp, EST_ABIERTA
    breq imprimir_abierta
    cpi temp, EST_CERRANDO
    breq imprimir_cerrando
    rjmp imprimir_detenida

imprimir_cerrada:
    ldi ZL, low(2 * texto_cerrada)
    ldi ZH, high(2 * texto_cerrada)
    call uart_texto
    rjmp imprimir_estado_fin

imprimir_abriendo:
    ldi ZL, low(2 * texto_abriendo)
    ldi ZH, high(2 * texto_abriendo)
    call uart_texto
    rjmp imprimir_estado_fin

imprimir_abierta:
    ldi ZL, low(2 * texto_abierta)
    ldi ZH, high(2 * texto_abierta)
    call uart_texto
    rjmp imprimir_estado_fin

imprimir_cerrando:
    ldi ZL, low(2 * texto_cerrando)
    ldi ZH, high(2 * texto_cerrando)
    call uart_texto
    rjmp imprimir_estado_fin

imprimir_detenida:
    ldi ZL, low(2 * texto_seguridad)
    ldi ZH, high(2 * texto_seguridad)
    call uart_texto

imprimir_estado_fin:
    ret

imprimir_obstaculo:
    ldi ZL, low(2 * texto_obstaculo)
    ldi ZH, high(2 * texto_obstaculo)
    call uart_texto
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
texto_inicio:
    .db 13, 10, "CONTROL PORTON", 13, 10, 0, 0
texto_cerrada:
    .db "PUERTA CERRADA", 13, 10, 0, 0
texto_abriendo:
    .db "PUERTA ABRIENDO", 13, 10, 0
texto_abierta:
    .db "PUERTA ABIERTA", 13, 10, 0, 0
texto_cerrando:
    .db "PUERTA CERRANDO", 13, 10, 0
texto_obstaculo:
    .db "OBSTACULO DETECTADO", 13, 10, 0
texto_seguridad:
    .db "MOVIMIENTO DETENIDO POR SEGURIDAD", 13, 10, 0

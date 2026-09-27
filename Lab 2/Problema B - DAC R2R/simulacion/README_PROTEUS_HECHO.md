# PROBLEMA B - SIMULACION PROTEUS

## Estado

El codigo ya esta compilado y listo para cargar en Proteus.

Archivo HEX:

```text
C:\Users\User\Documents\ChatGPT\Micro\Lab 2\Problema B - DAC R2R\compilacion\dac_r2r_uart.hex
```

## Componentes para colocar

- ATMEGA328P o Arduino UNO.
- Virtual Terminal.
- Osciloscopio.
- Red DAC R-2R de 8 bits.
- GND.

## Configuracion del micro

Si se usa ATMEGA328P:

- Clock Frequency: 16MHz.
- Program File: `dac_r2r_uart.hex`.

Si se usa Arduino UNO:

- Program File: `dac_r2r_uart.hex`.

## Conexion UART

| Micro / Arduino | Virtual Terminal |
| --- | --- |
| TX / D1 | RXD |
| RX / D0 | TXD |
| GND | GND |

Configurar Virtual Terminal a 9600 baudios.

## Conexion DAC R-2R

| Bit | Arduino | ATmega328P DIP | Peso |
| ---: | --- | --- | --- |
| 0 | D2 | PD2, pin 4 | LSB |
| 1 | D3 | PD3, pin 5 | |
| 2 | D4 | PD4, pin 6 | |
| 3 | D5 | PD5, pin 11 | |
| 4 | D6 | PD6, pin 12 | |
| 5 | D7 | PD7, pin 13 | |
| 6 | D8 | PB0, pin 14 | |
| 7 | D9 | PB1, pin 15 | MSB |

El bit 7 debe ir al lado de mayor peso de la red R-2R.

## Valores

Usar:

- R = 1k.
- 2R = 2k.

Tambien sirve:

- R = 10k.
- 2R = 20k.

## Osciloscopio

| Osciloscopio | Conexion |
| --- | --- |
| CH A | salida analogica de la red R-2R |
| GND | GND |

## Prueba

Al iniciar debe aparecer:

```text
LAB 2 - DAC R2R
1 SENAL 13
2 SENAL 15
+ MAS RAPIDO
- MAS LENTO
M MENU
```

Comandos:

| Tecla | Funcion |
| --- | --- |
| 1 | senal 13 |
| 2 | senal 15 |
| + | mas rapido |
| - | mas lento |
| m | menu |

## Capturas para entregar

- Circuito completo.
- Terminal con menu.
- Osciloscopio con senal 13.
- Osciloscopio con senal 15.

## Nota importante

El archivo de esquema de Proteus no se puede generar correctamente como texto porque el circuito se guarda en `ROOT.DSN`, que es binario. Por eso este paquete deja todos los archivos listos y las conexiones exactas para terminar el armado en el editor de Proteus.

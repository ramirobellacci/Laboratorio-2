# PROBLEMA B - SIMULACION EN PROTEUS

## Componentes

- Arduino UNO R3 o ATmega328P.
- Resistencias para red R-2R.
- Osciloscopio virtual.
- Virtual Terminal.
- GND.

## Archivo HEX

Usar el archivo:

```text
C:\Users\User\Documents\ChatGPT\Micro\Lab 2\Problema B - DAC R2R\compilacion\dac_r2r_uart.hex
```

## Pines del DAC

| Bit | Pin Arduino | Peso |
| ---: | --- | --- |
| 0 | D2 | LSB |
| 1 | D3 | |
| 2 | D4 | |
| 3 | D5 | |
| 4 | D6 | |
| 5 | D7 | |
| 6 | D8 | |
| 7 | D9 | MSB |

El bit 7, conectado a D9, debe quedar del lado de mayor peso de la red R-2R.

## UART

| Arduino | Virtual Terminal |
| --- | --- |
| D1 / TX | RXD |
| D0 / RX | TXD |
| GND | GND |

Configurar la terminal a 9600 baudios.

## Osciloscopio

| Osciloscopio | Conexion |
| --- | --- |
| CH A | salida analogica del DAC R-2R |
| GND | GND del Arduino |

## Prueba

1. Cargar el HEX en el Arduino de Proteus.
2. Ejecutar la simulacion.
3. Verificar que la terminal muestre el menu:

```text
LAB 2 - DAC R2R
1 SENAL 13
2 SENAL 15
+ MAS RAPIDO
- MAS LENTO
M MENU
```

4. Enviar `1` para ver la senal 13.
5. Enviar `2` para ver la senal 15.
6. Usar `+` y `-` para cambiar la velocidad.

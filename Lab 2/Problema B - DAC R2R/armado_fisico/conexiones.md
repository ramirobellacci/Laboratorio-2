# PROBLEMA B - ARMADO CON ATMEGA328P

## Componentes

| Cantidad | Componente |
| ---: | --- |
| 1 | ATmega328P, encapsulado DIP-28|
| 7 | resistencias de 1 k, valor R |
| 9 | resistencias de 2 k, valor 2R |
| 1 | adaptador USB-TTL de 5 V |
| 1 | protoboard y fuente regulada de 5 V |
| 1 | osciloscopio |


## Pines del DAC

| Bit | Puerto | Pin DIP | Equivalente Arduino | Peso |
| ---: | --- | ---: | --- | --- |
| 0 | PD2 | 4 | D2 | LSB |
| 1 | PD3 | 5 | D3 | |
| 2 | PD4 | 6 | D4 | |
| 3 | PD5 | 11 | D5 | |
| 4 | PD6 | 12 | D6 | |
| 5 | PD7 | 13 | D7 | |
| 6 | PB0 | 14 | D8 | |
| 7 | PB1 | 15 | D9 | MSB |


Orden de los nodos desde VOUT hacia la terminacion:

```text
VOUT -> bit7 -> R -> bit6 -> R -> bit5 -> R -> bit4
      -> R -> bit3 -> R -> bit2 -> R -> bit1 -> R -> bit0 -> 2R -> GND
```

Cada texto `bitN` representa un nodo que recibe el pin correspondiente a traves
de una resistencia 2R. No conectar un LED directamente a VOUT porque carga la
red y deforma la señal.


## Osciloscopio

| Osciloscopio | Conexion |
| --- | --- |
| punta del canal | VOUT de la red R-2R |
| tierra | GND comun |

Para comenzar, usar 1 V/div y 5 ms/div, acoplamiento DC. La salida teorica va de
0 V a aproximadamente 4,98 V y debe medirse con una entrada de alta impedancia.


## Prueba

Al encender, la terminal debe mostrar el menu. Las teclas `1` y `2` seleccionan
las señales 13 y 15; `+` y `-` cambian la velocidad, y `m` vuelve a mostrar el
menu.

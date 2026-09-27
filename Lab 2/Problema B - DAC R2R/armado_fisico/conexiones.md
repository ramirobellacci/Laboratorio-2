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

Conviene usar resistencias de 1 % en la red R-2R. Tambien se puede construir con
R = 10 k y 2R = 20 k.

## Alimentacion y reloj

| Pin DIP | Nombre | Conexion |
| ---: | --- | --- |
| 7 | VCC | +5 V |
| 20 | AVCC | +5 V |
| 8 | GND | GND |
| 22 | GND | GND |
| 21 | AREF | capacitor de 100 nF a GND |
| 9 | XTAL1 | un extremo del cristal de 16 MHz |
| 10 | XTAL2 | otro extremo del cristal de 16 MHz |
| 1 | RESET | resistencia de 10 k a +5 V |


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

## Red R-2R

Usar la topologia pasiva con la salida en el nodo del bit 7:

1. Formar ocho nodos, uno por bit, unidos entre si por siete resistencias R.
2. Conectar cada pin del ATmega a su nodo mediante una resistencia 2R.
3. El nodo del bit 7 es VOUT y queda junto al extremo de mayor peso.
4. Desde el nodo del bit 0 conectar una resistencia 2R adicional a GND como
   terminacion.

Orden de los nodos desde VOUT hacia la terminacion:

```text
VOUT -> bit7 -> R -> bit6 -> R -> bit5 -> R -> bit4
      -> R -> bit3 -> R -> bit2 -> R -> bit1 -> R -> bit0 -> 2R -> GND
```

Cada texto `bitN` representa un nodo que recibe el pin correspondiente a traves
de una resistencia 2R. No conectar un LED directamente a VOUT porque carga la
red y deforma la señal.

## UART

| ATmega328P | Adaptador USB-TTL |
| --- | --- |
| pin 3, PD1/TXD | RXD |
| pin 2, PD0/RXD | TXD |
| GND | GND |

Configurar la terminal a 9600 baudios, 8 bits, sin paridad y 1 bit de parada.
TX y RX van cruzados. Si el circuito ya tiene fuente propia, no unir tambien el
pin de 5 V del adaptador; solamente compartir GND.

## Osciloscopio

| Osciloscopio | Conexion |
| --- | --- |
| punta del canal | VOUT de la red R-2R |
| tierra | GND comun |

Para comenzar, usar 1 V/div y 5 ms/div, acoplamiento DC. La salida teorica va de
0 V a aproximadamente 4,98 V y debe medirse con una entrada de alta impedancia.

## Programacion por ISP

| Señal ISP | Pin ATmega328P DIP |
| --- | ---: |
| RESET | 1 |
| MOSI | 17 |
| MISO | 18 |
| SCK | 19 |
| VCC | 7 y 20 |
| GND | 8 y 22 |

El micro debe quedar configurado para usar el cristal externo de 16 MHz. Cargar
el archivo `compilacion/dac_r2r_uart.hex`. El monitor serial no requiere
bootloader; el bootloader solo es necesario si se pretende grabar por UART.

## Prueba

Al encender, la terminal debe mostrar el menu. Las teclas `1` y `2` seleccionan
las señales 13 y 15; `+` y `-` cambian la velocidad, y `m` vuelve a mostrar el
menu.

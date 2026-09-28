# PROBLEMA D

## IDEA DEL EJERCICIO

Se usan dos ATmega328P. El primero lee tres pulsadores y arma un numero binario de 3 bits. Ese numero se envia por UART al segundo ATmega328P. El segundo recibe el dato y prende una sola salida de acuerdo al valor recibido, desde 0 hasta 7.

## MATERIALES

| cantidad | material |
| ---: | --- |
| 2 | arduino uno compatible |
| 3 | pulsadores |
| 3 | resistencias de 10k si no se usan pull-up internos |
| 8 | leds |
| 8 | resistencias de 220 ohm a 1k para los leds |
| 1 | protoboard |
| varios | cables |

En el codigo se usan los pull-up internos, por eso los pulsadores van directo a GND.

## TRANSMISOR

| funcion | pin arduino |
| --- | --- |
| pulsador bit 0 | D2 |
| pulsador bit 1 | D3 |
| pulsador bit 2 | D4 |
| UART TX | D1 |
| GND | GND |

Cada pulsador se conecta entre su pin y GND.

## RECEPTOR

| valor recibido | salida | pin arduino |
| ---: | --- | --- |
| 0 | LED 0 | D2 |
| 1 | LED 1 | D3 |
| 2 | LED 2 | D4 |
| 3 | LED 3 | D5 |
| 4 | LED 4 | D6 |
| 5 | LED 5 | D7 |
| 6 | LED 6 | D8 |
| 7 | LED 7 | D9 |

Cada LED debe llevar resistencia en serie.

## UART ENTRE LOS DOS ARDUINOS

| transmisor | receptor |
| --- | --- |
| D1 TX | D0 RX |
| GND | GND |


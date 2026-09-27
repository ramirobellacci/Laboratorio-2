# Problema D

## Componentes

- 2 placas Arduino Uno compatibles con ATmega328P
- 3 pulsadores
- 8 LEDs
- 8 resistencias para los LEDs
- Protoboard y cables

## Conexiones

### Transmisor

| Componente | Pin Arduino |
| --- | --- |
| Pulsador del bit 0 | D2 a GND |
| Pulsador del bit 1 | D3 a GND |
| Pulsador del bit 2 | D4 a GND |
| TX UART | D1 |

Los pulsadores usan las resistencias pull-up internas.

### Receptor

| LED | Pin Arduino |
| ---: | --- |
| 0 | D2 |
| 1 | D3 |
| 2 | D4 |
| 3 | D5 |
| 4 | D6 |
| 5 | D7 |
| 6 | D8 |
| 7 | D9 |

Cada LED lleva una resistencia en serie.

### Conexion entre placas

| Transmisor | Receptor |
| --- | --- |
| D1 (TX) | D0 (RX) |
| GND | GND |

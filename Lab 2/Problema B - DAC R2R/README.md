# Problema B

## Componentes

- ATmega328P-PU en encapsulado DIP-28
- 7 resistencias de 1 kOhm para R
- 9 resistencias de 2 kOhm para 2R
- Adaptador USB-TTL de 5 V
- Protoboard y cables
- Osciloscopio

## Conexiones

| Bit del DAC | Pin del ATmega328P | Pin Arduino |
| ---: | --- | --- |
| 0 (LSB) | PD2, pin 4 | D2 |
| 1 | PD3, pin 5 | D3 |
| 2 | PD4, pin 6 | D4 |
| 3 | PD5, pin 11 | D5 |
| 4 | PD6, pin 12 | D6 |
| 5 | PD7, pin 13 | D7 |
| 6 | PB0, pin 14 | D8 |
| 7 (MSB) | PB1, pin 15 | D9 |

Los pines D2-D9 se conectan a la red R-2R. Cada pin va a su nodo a traves de
una resistencia 2R y los nodos se unen con resistencias R. La salida VOUT se
toma del nodo del bit 7; el nodo del bit 0 se termina con una resistencia 2R a
GND.

| Senal | Conexion |
| --- | --- |
| TX del ATmega (PD1, pin 3) | RXD del adaptador USB-TTL |
| RX del ATmega (PD0, pin 2) | TXD del adaptador USB-TTL |
| GND del ATmega | GND del adaptador y GND comun |
| Punta del osciloscopio | VOUT de la red R-2R |
| Tierra del osciloscopio | GND comun |

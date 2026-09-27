# Problema E

## Componentes

- Arduino Uno compatible con ATmega328P
- 5 pulsadores o llaves
- 3 LEDs
- 3 resistencias para los LEDs
- Protoboard y cables

## Conexiones

### Entradas

| Funcion | Pin Arduino | Conexion |
| --- | --- | --- |
| Boton abrir | D2 | Pulsador a GND |
| Boton cerrar | D3 | Pulsador a GND |
| Sensor puerta abierta | D4 | Pulsador o llave a GND |
| Sensor puerta cerrada | D5 | Pulsador o llave a GND |
| Sensor de obstaculo | D6 | Pulsador a GND |

Las entradas usan las resistencias pull-up internas.

### Salidas

| Funcion simulada | Pin Arduino |
| --- | --- |
| Motor abriendo | D8 |
| Motor cerrando | D9 |
| Alarma | D10 |

Cada LED se conecta al pin Arduino a traves de una resistencia; la otra pata del
LED va a GND.

### Comunicacion serial

| Senal | Pin Arduino |
| --- | --- |
| RX | D0 |
| TX | D1 |

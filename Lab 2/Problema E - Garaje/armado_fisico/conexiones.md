# PROBLEMA E

## IDEA DEL ARMADO

Se simula un porton de garaje usando LEDs. No se usa motor real.

El LED de D8 representa el motor abriendo.

El LED de D9 representa el motor cerrando.

El LED o buzzer de D10 representa la alarma.

Los pulsadores y sensores trabajan con pull-up interno. Por eso se conectan entre el pin y GND.

## MATERIALES

| cantidad | material |
| ---: | --- |
| 1 | arduino uno compatible |
| 5 | pulsadores o llaves |
| 3 | leds para salidas principales |
| 3 | resistencias para leds |
| 1 | protoboard |
| varios | cables |

Si se quiere ver mejor el estado de los sensores, se pueden agregar LEDs externos, pero no son necesarios para que funcione.

## ENTRADAS

| funcion | pin arduino | conexion |
| --- | --- | --- |
| boton abrir | D2 | pulsador a GND |
| boton cerrar | D3 | pulsador a GND |
| sensor puerta abierta | D4 | pulsador o llave a GND |
| sensor puerta cerrada | D5 | pulsador o llave a GND |
| sensor obstaculo | D6 | pulsador a GND |

## SALIDAS

| funcion real | simulacion con LED | pin arduino |
| --- | --- | --- |
| motor abrir | LED abriendo | D8 |
| motor cerrar | LED cerrando | D9 |
| alarma sonora | LED o buzzer | D10 |

Conexion de cada LED:

pin arduino -> resistencia -> pata larga del LED

pata corta del LED -> GND

## UART

| funcion | pin |
| --- | --- |
| RX | D0 |
| TX | D1 |
| velocidad | 9600 baudios |

Para ver los mensajes se puede usar el monitor serial a 9600 baudios.

## LOGICA

Si la puerta esta cerrada y se presiona abrir, se prende el LED de abrir y la alarma.

Cuando se activa el sensor de puerta abierta, se apagan el motor y la alarma.

Si la puerta esta abierta y se presiona cerrar, se prende el LED de cerrar y la alarma.

Cuando se activa el sensor de puerta cerrada, se apagan el motor y la alarma.

Si se activa el sensor de obstaculo mientras la puerta se mueve, el sistema apaga motor y alarma y queda detenido por seguridad.


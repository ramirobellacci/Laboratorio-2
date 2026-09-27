# PROBLEMA E - PORTON DE GARAJE

## DATOS GENERALES

Microcontrolador: ATmega328P en placa Arduino Uno compatible

Frecuencia: 16 MHz

Comunicacion serial: UART a 9600 baudios

Implementacion: maquina de estados

Actuadores reales simulados con LEDs

## ARCHIVOS

| carpeta | contenido |
| --- | --- |
| 01_codigo | codigo assembler final |
| 02_compilacion | archivo hex y capturas de compilacion |
| 03_simulacion | capturas o archivos de simulacion |
| 04_armado_fisico | fotos, videos y conexion |
| 05_informe | notas para el informe final |

## ESTADOS DEL SISTEMA

Puerta cerrada.

Puerta abriendo.

Puerta abierta.

Puerta cerrando.

Movimiento detenido por seguridad.

## EVENTOS POR UART

Puerta abriendo.

Puerta abierta.

Puerta cerrando.

Puerta cerrada.

Obstaculo detectado.

Movimiento detenido por seguridad.

## ESTADO

El codigo fue compilado localmente con avrasm2 y dio 0 errores y 0 advertencias.

El codigo fue compilado en Microchip Studio y dio 0 errores y 0 advertencias.

El programa fue grabado correctamente en el ATmega328P.

El armado fisico fue probado con LEDs para simular el porton, el motor y la alarma.

# PROBLEMA D - COMUNICACION USART UART

## DATOS GENERALES

Grupo: 1

Microcontroladores: 2 ATmega328P en placas Arduino Uno compatibles

Frecuencia: 16 MHz

Comunicacion: UART a 9600 baudios

Entrada del transmisor: 3 pulsadores

Salida del receptor: 8 LEDs indicadores

## ARCHIVOS

| carpeta | contenido |
| --- | --- |
| 01_codigo | codigos assembler del transmisor y receptor |
| 02_compilacion | archivos hex y capturas de compilacion |
| 03_simulacion | capturas o archivos de simulacion |
| 04_armado_fisico | fotos, videos y conexion |
| 05_informe | notas para el informe final |

## FUNCIONAMIENTO

El transmisor lee tres pulsadores conectados a D2, D3 y D4 usando resistencias pull-up internas. Con esos tres bits forma un valor entre 0 y 7. Ese dato se envia por UART desde el pin D1 del transmisor hacia el pin D0 del receptor.

El receptor espera el dato por UART. Cuando recibe un valor entre 0 y 7, apaga todas las salidas y prende solamente el LED correspondiente al valor recibido. Las salidas usadas son D2 a D9.

## CONEXION UART

TX del transmisor D1 hacia RX del receptor D0.

GND del transmisor unido con GND del receptor.

## EVIDENCIA DE COMPILACION

El codigo del transmisor fue compilado en Microchip Studio sin errores ni advertencias.

El codigo del receptor fue compilado en Microchip Studio sin errores ni advertencias.

## EVIDENCIA DE GRABACION

El transmisor fue grabado correctamente en un Arduino Uno compatible usando COM3.

El receptor fue grabado correctamente en un Arduino Uno compatible usando COM8.

## EVIDENCIA DE ARMADO FISICO

El circuito fue armado fisicamente con dos Arduino Uno compatibles. El transmisor uso tres pulsadores en D2, D3 y D4. El receptor uso ocho LEDs en D2 a D9.

La prueba funciono correctamente. Al cambiar la combinacion de pulsadores en el transmisor, el receptor encendio la salida correspondiente al valor binario recibido entre 000 y 111.

## NOTA PARA EL INFORME

Para el problema D se implemento una comunicacion UART entre dos microcontroladores ATmega328P. El primer microcontrolador funciona como transmisor y permite seleccionar un numero binario de 3 bits mediante tres pulsadores. El segundo microcontrolador funciona como receptor, decodifica el dato recibido y activa una salida entre ocho LEDs indicadores, representando los valores de 0 a 7.

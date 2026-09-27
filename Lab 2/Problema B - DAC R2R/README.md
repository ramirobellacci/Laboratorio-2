# PROBLEMA B - DAC R-2R

## DATOS GENERALES

Grupo: 1

Microcontrolador: ATmega328P-PU independiente, encapsulado DIP-28

Frecuencia: 16 MHz

Comunicacion serial: UART a 9600 baudios

Senales asignadas: 15 y 13

Salida: DAC R-2R de 8 bits

Resistencias usadas: R = 1k y 2R = 2k

## ARCHIVOS

| carpeta | contenido |
| --- | --- |
| 01_codigo | codigo assembler final |
| 02_compilacion | archivo hex final y capturas |
| 03_simulacion | capturas o archivos de simulacion |
| 04_armado_fisico | fotos, videos y conexion |
| 05_informe | notas para el informe final |

## FUNCIONES IMPLEMENTADAS

| tecla | funcion |
| --- | --- |
| 1 | reproducir senal 13 |
| 2 | reproducir senal 15 |
| + | aumentar frecuencia de muestreo |
| - | bajar frecuencia de muestreo |
| m | mostrar menu |

## LO QUE SE DEBE VERIFICAR

El codigo debe compilar en Microchip Studio sin errores ni avisos.

El monitor serial debe mostrar el menu a 9600 baudios.

El osciloscopio debe mostrar una onda analogica al medir la salida del DAC R-2R.

Las teclas 1 y 2 deben cambiar entre las senales 13 y 15.

Las teclas + y - deben modificar la frecuencia de salida.

## TEXTO PARA INFORME

Para el problema B se implemento un conversor digital-analogico R-2R de 8 bits controlado por un ATmega328P programado en lenguaje ensamblador. Las salidas digitales D2 a D9 generan los bits del dato de la LUT, donde D2 corresponde al bit menos significativo y D9 al bit mas significativo. Estos bits alimentan una red resistiva R-2R, cuya salida analogica se mide con el osciloscopio.

El programa utiliza dos tablas de consulta en memoria de programa, correspondientes a las senales 13 y 15 asignadas al grupo 1. Cada tabla contiene 256 muestras de 8 bits. La seleccion de la senal se realiza mediante comunicacion UART a 9600 baudios, usando un menu serial. La frecuencia de muestreo se controla con Timer1 en modo CTC y puede modificarse desde el puerto serial con las teclas + y -.

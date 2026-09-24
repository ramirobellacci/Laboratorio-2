# PROBLEMA A

## MATERIALES

| cantidad | material |
| ---: | --- |
| 1 | arduino uno compatible |
| 1 | matriz led 8x8 1088AS |
| 8 | resistencias de 1k para primera prueba |
| 8 | resistencias de 330 ohm o 220 ohm para prueba final |
| 1 | protoboard |
| varios | cables macho-macho |
| 1 | cable usb |

## PINES DE LA MATRIZ

| senal | pin matriz | pin arduino |
| --- | ---: | --- |
| f1 | 9 | d2 |
| f2 | 14 | d3 |
| f3 | 8 | d4 |
| f4 | 12 | d5 |
| f5 | 1 | d6 |
| f6 | 7 | d7 |
| f7 | 2 | d8 |
| f8 | 5 | d9 |
| c1 | 13 | d13 |
| c2 | 3 | d12 |
| c3 | 4 | d11 |
| c4 | 10 | d10 |
| c5 | 6 | a3 |
| c6 | 11 | a2 |
| c7 | 15 | a1 |
| c8 | 16 | a0 |

Las resistencias van en las columnas, que son los anodos:

| columna | conexion |
| --- | --- |
| c1 | d13 -> resistencia -> pin 13 matriz |
| c2 | d12 -> resistencia -> pin 3 matriz |
| c3 | d11 -> resistencia -> pin 4 matriz |
| c4 | d10 -> resistencia -> pin 10 matriz |
| c5 | a3 -> resistencia -> pin 6 matriz |
| c6 | a2 -> resistencia -> pin 11 matriz |
| c7 | a1 -> resistencia -> pin 15 matriz |
| c8 | a0 -> resistencia -> pin 16 matriz |


- probar resistencias de 330 ohm despues de confirmar que el dibujo es correcto.

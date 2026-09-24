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

## ANTES DE CONECTAR

Primero cargar el programa y abrir el monitor serial.

Configuracion del monitor serial:

| parametro | valor |
| --- | --- |
| baud | 9600 |
| data bits | 8 |
| paridad | none |
| stop bits | 1 |

Si no aparece el menu, mandar la letra m.

## PINES DE LA MATRIZ

Colocar la matriz con la muesca o marca hacia arriba.

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

## ORDEN DE PRUEBA

1. Cargar el hex en el arduino.
2. Abrir monitor serial a 9600.
3. Verificar que aparece el menu.
4. Mandar m si el menu no aparece.
5. Conectar solo la alimentacion por usb.
6. Conectar la matriz con resistencias de 1k.
7. Mandar 5 para ver el patron de prueba.
8. Mandar 2, 3 y 4 para ver las figuras.
9. Mandar 1 para ver el texto.
10. Probar + y - para cambiar la velocidad.

## SI SALE MAL

Si no prende nada:

- revisar que la muesca de la matriz este hacia arriba.
- revisar que d0 y d1 no esten conectados a la matriz.
- revisar que todas las tierras sean comunes.
- cambiar el grupo de filas por columnas si el pinout del fabricante esta invertido.

Si se ve espejado:

- dejar el cableado como esta y corregir el orden de columnas en el codigo.

Si se ve invertido verticalmente:

- dejar el cableado como esta y corregir el orden de filas en el codigo.

Si prende muy poco:

- probar resistencias de 330 ohm despues de confirmar que el dibujo es correcto.

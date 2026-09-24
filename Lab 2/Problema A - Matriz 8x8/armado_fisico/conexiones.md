# PROBLEMA A

## CONEXION MATRIZ 1088AS

Usar resistencias de 220 ohm o 330 ohm en las lineas positivas de la matriz.

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

## UART

| senal | pin arduino |
| --- | --- |
| rx | d0 |
| tx | d1 |
| velocidad | 9600 |

## MENU

| tecla | funcion |
| --- | --- |
| 1 | mensaje desplazandose |
| 2 | corazon |
| 3 | cara |
| 4 | flecha |
| 5 | prueba de matriz |
| + | mas rapido |
| - | mas lento |
| m | mostrar menu |

## NOTAS

Si la matriz se ve invertida o espejada, primero revisar que la muesca del componente este bien orientada.

Si no prende nada, probar invertir el criterio de filas y columnas en el armado, porque algunos vendedores nombran filas y columnas al reves aunque el modelo sea 1088AS.

# PROBLEMA B

## MATERIALES

| cantidad | material |
| ---: | --- |
| 1 | arduino uno compatible |
| 8 | resistencias R |
| 8 | resistencias 2R |
| 1 | protoboard |
| varios | cables |
| 1 | osciloscopio |

Valores usados en el armado:

| resistencia | valor |
| --- | --- |
| R | 1k |
| 2R | 2k |

Tambien se puede usar:

| resistencia | valor |
| --- | --- |
| R | 10k |
| 2R | 20k |

## PINES DEL DAC

| bit | pin arduino | peso |
| ---: | --- | --- |
| 0 | d2 | lsb |
| 1 | d3 |  |
| 2 | d4 |  |
| 3 | d5 |  |
| 4 | d6 |  |
| 5 | d7 |  |
| 6 | d8 |  |
| 7 | d9 | msb |

El bit 7 es el mas importante del DAC y debe ir al lado de mayor peso de la red R-2R.

## UART

| senal | pin arduino |
| --- | --- |
| rx | d0 |
| tx | d1 |
| velocidad | 9600 |

## OSCILOSCOPIO

| osciloscopio | conexion |
| --- | --- |
| punta | salida analogica del R-2R |
| tierra | GND del arduino |

## MENU

| tecla | funcion |
| --- | --- |
| 1 | senal 13 |
| 2 | senal 15 |
| + | mas rapido |
| - | mas lento |
| m | mostrar menu |

## NOTAS

La tierra del osciloscopio debe ir al mismo GND del arduino.

Si la onda se ve invertida o rara, revisar primero el orden de bits del DAC.

Si la amplitud es baja, revisar que el bit 7 este conectado al lado de mayor peso.

# PROBLEMA B - SIMULACION EN PROTEUS CON ATMEGA328P

## Componentes para buscar

- `ATMEGA328P`, seleccionando el encapsulado DIP-28
- `CRYSTAL`
- `CAP`, dos de 22 pF y tres de 100 nF
- `RES`, valores 1 k, 2 k y 10 k
- terminales `VCC` y `GROUND`
- `VIRTUAL TERMINAL`
- `OSCILLOSCOPE`

## Configuracion del ATmega

Abrir las propiedades del ATmega y configurar:

| Propiedad | Valor |
| --- | --- |
| Program File | `C:\Users\User\Documents\ChatGPT\Micro\Lab 2\Problema B - DAC R2R\compilacion\dac_r2r_uart.hex` |
| Clock Frequency | `16MHz` |

Aunque Proteus usa la propiedad `Clock Frequency` para la simulacion, dibujar el
cristal de 16 MHz y sus dos capacitores de 22 pF hace que el esquema coincida con
el montaje fisico.

## Circuito minimo

| Pin DIP | Nombre | Conexion |
| ---: | --- | --- |
| 1 | RESET | 10 k a +5 V |
| 7 | VCC | +5 V |
| 8 | GND | GND |
| 9 y 10 | XTAL1/XTAL2 | cristal de 16 MHz; cada extremo con 22 pF a GND |
| 20 | AVCC | +5 V |
| 21 | AREF | 100 nF a GND |
| 22 | GND | GND |

Agregar 100 nF entre VCC-GND y otro entre AVCC-GND.

En algunas bibliotecas de Proteus los pines de alimentacion aparecen ocultos.
En ese caso, colocar terminales de potencia llamados exactamente `VCC` y `GND`;
el modelo los conecta internamente a esos pines.

## DAC R-2R

| Bit | Puerto | Pin DIP | Posicion en la red |
| ---: | --- | ---: | --- |
| 7 | PB1 | 15 | primer nodo, junto a VOUT |
| 6 | PB0 | 14 | segundo nodo |
| 5 | PD7 | 13 | tercer nodo |
| 4 | PD6 | 12 | cuarto nodo |
| 3 | PD5 | 11 | quinto nodo |
| 2 | PD4 | 6 | sexto nodo |
| 1 | PD3 | 5 | septimo nodo |
| 0 | PD2 | 4 | ultimo nodo, junto a la terminacion |

Unir los ocho nodos con siete resistencias R = 1 k. Cada pin llega a su nodo por
una resistencia 2R = 2 k. Desde el nodo del bit 0 agregar otra resistencia de
2 k a GND. La salida analogica VOUT se toma en el nodo del bit 7.

## Terminal y osciloscopio

| ATmega | Virtual Terminal |
| --- | --- |
| pin 3, PD1/TXD | RXD |
| pin 2, PD0/RXD | TXD |

Configurar `9600`, 8 bits, sin paridad y 1 bit de parada. Unir las tierras.
Conectar el canal A del osciloscopio a VOUT y su referencia a GND. Comenzar con
1 V/div, 5 ms/div y acoplamiento DC.

## Prueba

Al ejecutar debe aparecer:

```text
LAB 2 - DAC R2R
1 SENAL 13
2 SENAL 15
+ MAS RAPIDO
- MAS LENTO
M MENU
```

Enviar `1` y `2` para cambiar de señal. Usar `+` y `-` para modificar la
frecuencia.

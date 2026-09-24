# PROBLEMA A - MATRIZ 8X8

## DATOS GENERALES

Grupo: 1

Microcontrolador: ATmega328P en placa Arduino Uno compatible

Frecuencia: 16 MHz

Comunicacion serial: UART a 9600 baudios

Matriz usada: 8x8 modelo 1088AS, 16 pines

Mensaje usado: MICROS LO MEJOR

## ARCHIVOS

| carpeta | contenido |
| --- | --- |
| `codigo` | codigo assembler final |
| `compilacion` | archivos HEX, LST, MAP y captura de compilacion |
| `simulacion` | capturas o archivos de Proteus |
| `armado_fisico` | conexiones, guia, fotos y video |

El informe general del laboratorio se encuentra en `../informe_final_overleaf`.

## FUNCIONES IMPLEMENTADAS

El programa muestra un menu por UART al iniciar. El usuario puede elegir entre el texto desplazandose y tres figuras fijas.

| tecla | funcion |
| --- | --- |
| 1 | mensaje desplazandose |
| 2 | corazon |
| 3 | cara |
| 4 | flecha |
| 5 | patron de prueba |
| + | mas rapido |
| - | mas lento |
| m | mostrar menu |

## LO QUE FUNCIONO

El codigo compilo en Microchip Studio sin errores.

El programa fue grabado correctamente en el ATmega328P usando avrdude por COM3.

La grabacion final confirmo escritura y verificacion de la memoria flash.

El monitor serial respondio correctamente a 9600 baudios.

La matriz 1088AS funciono fisicamente despues de corregir un problema de hardware: una resistencia defectuosa causaba una columna con brillo anormal.

La prueba con la tecla 5 mostro un patron tipo ajedrezado, util para verificar filas y columnas.

Se corrigio la tabla del texto para que la letra M se visualice correctamente.

Se ajustaron las teclas + y - para que el cambio de velocidad sea mas visible.

## PROBLEMAS ENCONTRADOS

La simulacion en Proteus no pudo ejecutarse en esta instalacion porque el simulador mostro el error:

```text
AVR2.DLL failed to authorize - Product Key not found
```

El problema corresponde a licencia o autorizacion del modelo AVR, no al codigo ni al circuito.

Durante el armado fisico se detecto una columna con brillo excesivo. La causa fue una resistencia defectuosa.

## EVIDENCIAS QUE FALTAN AGREGAR

Agregar capturas de Microchip Studio con 0 errores y 0 warnings en la carpeta `compilacion`.

Agregar captura del error de Proteus en la carpeta `simulacion`.

Agregar foto del armado fisico en la carpeta `armado_fisico`.

Agregar video de funcionamiento fisico en la carpeta `armado_fisico`.

Los archivos de texto `poner_aqui_capturas.txt` y `poner_aqui_fotos_y_videos.txt`
son recordatorios temporales y deben reemplazarse por las evidencias reales antes
de entregar el repositorio.

## TEXTO PARA INFORME

Para el problema A se implemento un sistema de control de una matriz LED 8x8 utilizando un ATmega328P programado en lenguaje ensamblador. El sistema utiliza comunicacion UART a 9600 baudios para presentar un menu de seleccion al usuario. Mediante dicho menu se puede visualizar un mensaje desplazable y distintas figuras predefinidas. El mensaje utilizado fue "MICROS LO MEJOR". Ademas, se incorporo una opcion de prueba para comprobar el correcto mapeo de filas y columnas de la matriz fisica.

El desplazamiento del texto se realizo mediante una tabla de consulta en memoria de programa. Cada cuadro de la animacion contiene ocho bytes, uno por cada fila de la matriz. El barrido se realiza multiplexando las filas y cargando el patron correspondiente en las columnas. La velocidad del desplazamiento puede modificarse desde el puerto serial mediante las teclas + y -.

La simulacion en Proteus no pudo completarse debido a una limitacion de licencia del modelo AVR. El error mostrado fue "AVR2.DLL failed to authorize - Product Key not found". Luego se realizo la prueba fisica sobre una placa Arduino Uno compatible con ATmega328P, verificando primero la comunicacion serial y posteriormente el funcionamiento de la matriz 1088AS. Durante la prueba fisica se encontro una resistencia defectuosa, la cual provocaba una columna con brillo excesivo. Al reemplazarla, la matriz funciono correctamente.

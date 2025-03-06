# 2048 Game en Godot 4

## Descripción

Este es un juego de **2048** implementado en **Godot 4**. El objetivo del juego es deslizar las piezas numeradas dentro de una cuadrícula 4x4 para combinarlas y alcanzar el número **2048**. Al combinar piezas de igual valor, se duplican y se suman. El juego termina cuando no es posible mover las piezas.

### Reglas Básicas

- El tablero tiene un tamaño de 4x4, con celdas que pueden contener números como 2, 4, 8, 16, 32, etc.
- Se combinan las celdas con el mismo valor para sumar su total.
- El jugador puede mover las piezas en las direcciones: **arriba**, **abajo**, **izquierda** y **derecha** usando las teclas correspondientes.
- Un nuevo número (2 o 4) aparecerá en una celda vacía después de cada movimiento.
- El juego termina cuando ya no hay más movimientos posibles.

## Características

- **Tablero 4x4**: Un espacio donde los números se combinan y se suman para alcanzar el 2048.
- **Colores dinámicos**: Cada número tiene un color específico que ayuda a diferenciarlo visualmente.
- **Lógica de movimientos**: Puedes mover las piezas en las direcciones básicas (arriba, abajo, izquierda, derecha).
- **Verificación de Game Over**: Si no hay más movimientos disponibles, el juego termina.

## Instalación

Para ejecutar este juego en tu máquina, sigue estos pasos:

### 1. Clona el repositorio:

```bash
git clone https://github.com/TuUsuario/2048-game-godot.git
```

### 2. Abre el proyecto en Godot:

- Abre Godot 4 y selecciona "Abrir Proyecto".
- Navega hasta la carpeta donde clonaste el repositorio y selecciona el proyecto.

### 3. Ejecuta el juego:

Una vez que el proyecto esté abierto, puedes ejecutar el juego directamente desde el editor de Godot haciendo clic en **"Play"** o presionando **F5**.

## Jugabilidad

### Controles:

- **Flecha Derecha**: Mueve todas las piezas a la derecha.
- **Flecha Izquierda**: Mueve todas las piezas a la izquierda.
- **Flecha Arriba**: Mueve todas las piezas hacia arriba.
- **Flecha Abajo**: Mueve todas las piezas hacia abajo.

### Objetivo:

El objetivo es combinar las piezas hasta llegar al número **2048**. Si alcanzas este número, ¡ganaste! Sin embargo, si el tablero se llena y no puedes hacer más movimientos, el juego terminará.

## Estructura del Proyecto

Este proyecto está organizado de la siguiente manera:

```
/2048-game-godot
│
├── /scenes
│   ├── panel.tscn        # Escena para cada celda del tablero
│   └── main.tscn         # Escena principal del juego
│
├── /scripts
│   └── game.gd           # Lógica del juego
│
├── /assets
│   └── tiles/            # Imágenes y recursos visuales (si aplican)
└── README.md             # Este archivo
```

- La **escena `panel.tscn`** contiene la representación visual de cada celda del tablero.
- El **script `game.gd`** maneja la lógica del juego, incluyendo el movimiento y la fusión de tiles.

## Contribución

Si quieres contribuir a este proyecto, sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature/mi-nueva-funcionalidad`).
3. Realiza los cambios y haz commit (`git commit -am 'Añadir nueva funcionalidad'`).
4. Haz push a tu rama (`git push origin feature/mi-nueva-funcionalidad`).
5. Abre un pull request para que podamos revisar y fusionar tus cambios.

## Licencia

Este proyecto está licenciado bajo la licencia MIT - consulta el archivo [LICENSE](LICENSE) para más detalles.

## Agradecimientos

- Este proyecto está inspirado en el popular juego **2048**, creado por **Gabriele Cirulli**.

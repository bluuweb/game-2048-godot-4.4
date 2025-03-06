extends Node2D

# Configuración de la grid
var grid_size = Vector2(4, 4)  # 4x4
var cell_size = 100            # Tamaño de cada celda (en píxeles)
var spacing = 10               # Espaciado entre celdas
var grid_origin = Vector2(50, 50)  # Esquina superior izquierda de la grid

# Grid lógica (matriz 4x4)
var grid: Array = [
	[0, 0, 0, 0],
	[0, 0, 0, 0],
	[0, 0, 0, 0],
	[0, 0, 0, 0]
]

# Diccionario para mapear valores a colores (opcional)
var tile_colors = {
	0: Color(0.9, 0.9, 0.9),  # Vacío
	2: Color(0.93, 0.88, 0.79),
	4: Color(0.93, 0.86, 0.65),
	8: Color(0.95, 0.68, 0.48),
	16: Color(0.96, 0.58, 0.39),
	32: Color(0.96, 0.48, 0.35),
	64: Color(0.96, 0.38, 0.24),
	128: Color(0.93, 0.88, 0.39),
	256: Color(0.93, 0.86, 0.35),
	512: Color(0.93, 0.84, 0.31),
	1024: Color(0.93, 0.82, 0.27),
	2048: Color(0.93, 0.8, 0.23)
}

# Diccionario para mapear posiciones de la grid a nodos visuales
var tiles: Dictionary = {}

# Función _ready: Inicializar el juego
func _ready():
	spawn_new_tile()

# Función para calcular la posición de una celda
func get_cell_position(row: int, col: int) -> Vector2:
	return grid_origin + Vector2(col * (cell_size + spacing), row * (cell_size + spacing))

# Función para instanciar un nuevo cuadro
func spawn_tile(row: int, col: int, value: int):
	var tile_scene = preload("res://scenes/panel.tscn")
	var tile_instance = tile_scene.instantiate()
	
	# Configurar el número y el color
	tile_instance.get_node("Label").text = str(value)
	tile_instance.modulate = tile_colors[value]
	
	# Posicionar el cuadro
	tile_instance.position = get_cell_position(row, col)
	
	# Añadir el cuadro a la escena
	add_child(tile_instance)
	tiles[Vector2(row, col)] = tile_instance

# Función para generar un nuevo número en una celda vacía
func spawn_new_tile():
	var empty_cells = []
	for row in range(4):
		for col in range(4):
			if grid[row][col] == 0:
				empty_cells.append(Vector2(row, col))
	
	if empty_cells.size() > 0:
		var random_cell = empty_cells[randi() % empty_cells.size()]
		var new_value = [2, 4][randi() % 2]
		grid[int(random_cell.x)][int(random_cell.y)] = new_value
		spawn_tile(int(random_cell.x), int(random_cell.y), new_value)

# Detectar entrada del jugador
func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_RIGHT:
			move_right()
		elif event.keycode == KEY_LEFT:
			move_left()
		elif event.keycode == KEY_UP:
			move_up()
		elif event.keycode == KEY_DOWN:
			move_down()
		check_game_over()
			
func update_visuals():
	# Eliminar todos los tiles existentes
	for tile in tiles.values():
		tile.queue_free()
	tiles.clear()
	
	# Crear nuevos tiles basados en la grid actualizada
	for row in range(grid_size.y):
		for col in range(grid_size.x):
			if grid[row][col] != 0:
				spawn_tile(row, col, grid[row][col])

# Función para mover hacia la izquierda
func move_left():
	var moved = false  # Para verificar si hubo algún cambio en la grid
	
	for row in range(grid_size.y):
		var new_row = []  # Fila temporal para almacenar los números movidos
		var last_merged = false  # Para evitar fusiones múltiples en una sola pasada
		
		for col in range(grid_size.x):
			if grid[row][col] != 0:
				if new_row.size() > 0 and new_row[-1] == grid[row][col] and not last_merged:
					# Fusionar con el último número si son iguales
					new_row[-1] *= 2
					last_merged = true
					moved = true
				else:
					# Agregar el número a la nueva fila
					new_row.append(grid[row][col])
					last_merged = false
					if col != len(new_row) - 1:
						moved = true
		
		# Rellenar el resto de la fila con ceros
		while new_row.size() < grid_size.x:
			new_row.append(0)
		
		# Actualizar la fila en la grid
		if grid[row] != new_row:
			grid[row] = new_row
			moved = true
	
	if moved:
		update_visuals()
		spawn_new_tile()

# Funciones para mover en otras direcciones (similares a move_left)
func move_right():
	var moved = false
	
	for row in range(grid_size.y):
		var new_row = []
		var last_merged = false
		
		for col in range(grid_size.x - 1, -1, -1):
			if grid[row][col] != 0:
				if new_row.size() > 0 and new_row[0] == grid[row][col] and not last_merged:
					new_row[0] *= 2
					last_merged = true
					moved = true
				else:
					new_row.insert(0, grid[row][col])
					last_merged = false
					if col != grid_size.x - len(new_row):
						moved = true
		
		# Rellenar el resto de la fila con ceros
		while new_row.size() < grid_size.x:
			new_row.insert(0, 0)
		
		# Actualizar la fila en la grid
		if grid[row] != new_row:
			grid[row] = new_row
			moved = true
	
	if moved:
		update_visuals()
		spawn_new_tile()

func move_up():
	var moved = false
	
	for col in range(grid_size.x):
		var new_col = []
		var last_merged = false
		
		for row in range(grid_size.y):
			if grid[row][col] != 0:
				if new_col.size() > 0 and new_col[-1] == grid[row][col] and not last_merged:
					new_col[-1] *= 2
					last_merged = true
					moved = true
				else:
					new_col.append(grid[row][col])
					last_merged = false
					if row != len(new_col) - 1:
						moved = true
		
		# Rellenar el resto de la columna con ceros
		while new_col.size() < grid_size.y:
			new_col.append(0)
		
		# Actualizar la columna en la grid
		for row in range(grid_size.y):
			if grid[row][col] != new_col[row]:
				grid[row][col] = new_col[row]
				moved = true
	
	if moved:
		update_visuals()
		spawn_new_tile()

func move_down():
	var moved = false
	
	for col in range(grid_size.x):
		var new_col = []
		var last_merged = false
		
		for row in range(grid_size.y - 1, -1, -1):
			if grid[row][col] != 0:
				if new_col.size() > 0 and new_col[0] == grid[row][col] and not last_merged:
					new_col[0] *= 2
					last_merged = true
					moved = true
				else:
					new_col.insert(0, grid[row][col])
					last_merged = false
					if row != grid_size.y - len(new_col):
						moved = true
		
		# Rellenar el resto de la columna con ceros
		while new_col.size() < grid_size.y:
			new_col.insert(0, 0)
		
		# Actualizar la columna en la grid
		for row in range(grid_size.y):
			if grid[row][col] != new_col[row]:
				grid[row][col] = new_col[row]
				moved = true
	
	if moved:
		update_visuals()
		spawn_new_tile()

func check_game_over():	
	print("🔍 Verificando Game Over...")

	var no_moves_left = true  # Suponemos que no hay movimientos

	# ✅ **Verificar si hay espacios vacíos**
	for row in range(grid_size.y):
		for col in range(grid_size.x):
			if grid[row][col] == 0:  # Verificar si hay espacios vacíos en la grid
				print("✅ Aún hay espacios vacíos en ", row, col)
				return  # Todavía se puede jugar

	# ✅ **Verificar si hay combinaciones posibles en filas**
	for row in range(grid_size.y):
		for col in range(grid_size.x - 1):
			if grid[row][col] == grid[row][col + 1]:  # Verificar si hay combinaciones posibles en la fila
				print("✅ Movimiento posible en horizontal en ", row, col)
				return  # Aún hay combinaciones

	# ✅ **Verificar si hay combinaciones posibles en columnas**
	for col in range(grid_size.x):
		for row in range(grid_size.y - 1):
			if grid[row][col] == grid[row + 1][col]:  # Verificar si hay combinaciones posibles en la columna
				print("✅ Movimiento posible en vertical en ", row, col)
				return  # Aún hay combinaciones

	# ❌ **Si no hay espacios ni combinaciones, es Game Over**
	print("❌ ¡GAME OVER!")

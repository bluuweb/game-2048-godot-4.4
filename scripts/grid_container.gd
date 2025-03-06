extends GridContainer

var grid_size: int = 4
var grid: Array[Array]
const PANEL = preload("res://scenes/panel.tscn")

func _ready() -> void:
	# Iniciar la grid vacía
	grid = []
	for i in range(grid_size):
		grid.append([])  # Crear una fila vacía
		for j in range(grid_size):
			grid[i].append(0)  # Llenar la fila con ceros
	
	# Generar dos tiles al azar al inicio
	spawn_random_tile()

func spawn_random_tile():
	var empty_positions = []
	for x in range(grid_size):
		for y in range(grid_size):
			if grid[x][y] == 0:
				empty_positions.append(Vector2(x, y))
	
	if empty_positions.size() > 0:
		var random_pos = empty_positions[randi() % empty_positions.size()]
		print("random_pos ", random_pos)
		grid[int(random_pos.x)][int(random_pos.y)] = 2
		create_tile(random_pos)

func create_tile(position: Vector2):
	# Crear un nuevo panel para representar el Tile
	var panel = PANEL.instantiate()
	panel.position = position
	add_child(panel)
	grid[int(position.x)][int(position.y)] = 2

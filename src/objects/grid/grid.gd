## The game world, where all action happens.
extends Node2D

## Emitted when the snake eats its food.
signal food_eaten()

## Emitted when, you know, the game is over.
signal game_over()

## The default, smallest distance from the grid border the snake head should
## spawn at.
const DEFAULT_SPAWN_MARGIN: int = 5

## The snake default size.
const DEFAULT_SNAKE_SIZE: int = 5

## Grid default width.
const GRID_DEFAULT_WIDTH: int = 16

## Grid default height.
const GRID_DEFAULT_HEIGHT: int = 16

## Grid maximum width.
const GRID_MAXIMUM_WIDTH: int = 32

## Grid maximum height.
const GRID_MAXIMUM_HEIGHT: int = 32

@export_group("Grid Dimensions", "grid_")
## The world width, in grid units.
@export_range(1, GRID_MAXIMUM_WIDTH, 1, "suffix:cells")
var grid_width: int = GRID_DEFAULT_WIDTH

## The world height, in grid units.
@export_range(1, GRID_MAXIMUM_HEIGHT, 1, "suffix:cells")
var grid_height: int = GRID_DEFAULT_HEIGHT

@export_group("Snake")
## The snake initial size.
@export_range(1, 8, 1, "suffix:cells")
var initial_snake_size: int = DEFAULT_SNAKE_SIZE

## The smallest distance from the grid border the snake head should spawn at.
@export_range(0, 8, 1, "suffix:cells")
var spawn_margin: int = DEFAULT_SPAWN_MARGIN

## Whether this game is paused or not.
var is_paused: bool = false:
	get:
		return $Timer.paused
	set(value):
		$Timer.paused = value

## The list of all available cell coordinates on the grid.
@onready
var _grid_cells: Array[Vector2i] = _get_cell_coordinates_list()


func _ready() -> void:
	_reset_snake()
	_reset_food()


## Increases game difficulty, making the snake move faster.
func increase_pace() -> void:
	if $Timer.wait_time > 0.08:
		$Timer.wait_time -= 0.02


## Makes the snake turn left the next step.
func snake_turn_left() -> void:
	if not is_paused:
		$Snake.turn_left()


## Makes the snake turn right the next step.
func snake_turn_right() -> void:
	if not is_paused:
		$Snake.turn_right()


## Starts the game, activating its timer.
func start() -> void:
	$Timer.start()


## Advances the game state.
func step() -> void:
	var cell: Vector2i = $Snake.get_next_step(grid_width, grid_height)
	if $Snake.will_collide(cell):
		$Timer.stop()
		game_over.emit()
	elif $Food.cell == cell:
		$Snake.add_segment(cell)
		_reset_food()
		food_eaten.emit()
	else:
		$Snake.walk(cell)


## Builds an array of grid cells to be queried later.
func _get_cell_coordinates_list() -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	for i: int in grid_width * grid_height:
		@warning_ignore("integer_division")
		result.push_back(Vector2i(i % grid_width, i / grid_width))
	return result


## Returns the list of remaining cells on the grid.
func _get_free_cells(snake_cells: Array[Vector2i]) -> Array[Vector2i]:
	return _grid_cells.filter(func(cell): return not cell in snake_cells)


## Gets a random direction to face the snake head at the start of the game.
func _get_random_direction() -> Vector2i:
	var r := randf()
	if r > 0.75:
		return Vector2i.UP
	elif r > 0.5:
		return Vector2i.RIGHT
	elif r > 0.25:
		return Vector2i.DOWN
	else:
		return Vector2i.LEFT


## Chooses a random cell inside the grid, with a given distance from the grid's
## edge, where the snake head should appear at the start of the game.
func _get_random_spawn_cell(margin: int = 0) -> Vector2i:
	var x := randi_range(margin, grid_width - margin - 1)
	var y := randi_range(margin, grid_height - margin - 1)
	return Vector2i(x, y)


## Chooses a random free cell on the grid to place a new piece of food, or
## emits [signal game_over] if none is available.
func _reset_food() -> void:
	var free_cells := _get_free_cells($Snake.get_occupied_cells())
	if free_cells.is_empty():
		game_over.emit()
	else:
		$Food.cell = free_cells[randi_range(0, len(free_cells) - 1)]


## Initializes the snake on the grid.
func _reset_snake() -> void:
	$Snake.initialize(initial_snake_size, _get_random_spawn_cell(spawn_margin), _get_random_direction())

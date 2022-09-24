## Grid
##
## The game world, where all game action happens.
class_name Grid
extends Node2D

## Emitted when the snake eats its food.
signal food_eaten

## Emitted when, you know, the game is over.
signal game_over

## Grid cell size.
const CELL_SIZE: int = 16

## An array of orthogonal directions. Used to initialize the snake on the grid.
const DIRECTIONS := [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]

## Grid default width.
const GRID_DEFAULT_WIDTH: int = 16

## Grid default height.
const GRID_DEFAULT_HEIGHT: int = 16

## Grid maximum width.
const GRID_MAXIMUM_WIDTH: int = 16

## Grid maximum height.
const GRID_MAXIMUM_HEIGHT: int = 16

## The world height, in grid units.
export(int, 1, 32) var grid_height: int = GRID_DEFAULT_HEIGHT

## The world width, in grid units.
export(int, 1, 32) var grid_width: int = GRID_DEFAULT_WIDTH

## Whether this game is paused or not.
var paused: bool = false setget set_paused, is_paused

## This grid's randomizer.
var rng := RandomNumberGenerator.new()

## The list of all available cell coordinates on the grid.
onready var grid_cells: Array = get_cell_coordinates_list(grid_width, grid_height)


## Build an array of grid cells to be queried later.
static func get_cell_coordinates_list(width: int, height: int) -> Array:
	var result := []
	for y in height:
		for x in width:
			result.push_back(Vector2(x, y))
	return result


## Returns the list of remaining cells on the grid.
func get_free_cells(snake_cells: Array) -> Array:
	var result := grid_cells.duplicate()
	for cell in snake_cells:
		result.erase(cell)
	return result


## Get a random direction to face the snake.
static func get_random_direction(p_rng: RandomNumberGenerator) -> Vector2:
	return DIRECTIONS[p_rng.randi_range(0, len(DIRECTIONS) - 1)]


## Get a random coordinate on the grid to spawn the snake.
func get_random_spawn_cell(margin: int = 0) -> Vector2:
	var x := rng.randi_range(margin, grid_width - margin - 1)
	var y := rng.randi_range(margin, grid_height - margin - 1)
	return Vector2(x, y)


## Increases game difficulty, making the snake move faster.
func increase_pace() -> void:
	if $Timer.wait_time > 0.08:
		$Timer.wait_time -= 0.02


## Returns true if the game timer is paused.
func is_paused() -> bool:
	return $Timer.paused


## Places the food on a free grid cell.
func reset_food() -> void:
	var free_cells := get_free_cells($Snake.get_occupied_cells())
	if free_cells.empty():
		emit_signal("game_over")
	else:
		$Food.cell = free_cells[rng.randi_range(0, len(free_cells) - 1)]


## Initializes the snake on the grid.
func reset_snake() -> void:
	$Snake.initialize(5, get_random_spawn_cell(4), get_random_direction(rng))


## Toggles the state of the game timer.
func set_paused(value: bool) -> void:
	$Timer.paused = value


## Starts the game, activating its timer.
func start() -> void:
	$Timer.start()


## Advances the game state.
func step() -> void:
	var next_cell: Vector2 = $Snake.get_next_cell(grid_width, grid_height)
	if $Snake.will_collide(next_cell):
		$Timer.stop()
		emit_signal("game_over")
	elif $Food.is_same_cell(next_cell):
		$Snake.add_segment(next_cell)
		reset_food()
		emit_signal("food_eaten")
	else:
		$Snake.walk(next_cell)


## Makes the snake turn left the next step.
func snake_turn_left() -> void:
	if not is_paused():
		$Snake.turn_left()


## Makes the snake turn right the next step.
func snake_turn_right() -> void:
	if not is_paused():
		$Snake.turn_right()


func _ready() -> void:
	rng.randomize()
	reset_snake()
	reset_food()

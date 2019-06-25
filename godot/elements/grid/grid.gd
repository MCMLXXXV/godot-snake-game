"""
Grid
====

Where all game action happens.

You can play test the game in its minimal form typing [F6] to test it.
Use [←] and [→] keys to change direction.
"""
extends Control


"""
Emitted when, you know, the game is over.
"""
signal game_over


"""
Emitted when the score updates.
Required to update the displayed score in the UI.
"""
signal score_updated(points)


"""
The grid width. This measumement is calculated at runtime, based on the parent
container dimensions, so the game world can scale dynamically.
"""
onready var grid_width: int = max(Grid.MINIMUM_WIDTH, floor(rect_size.x / Grid.CELL_LENGTH)) as int


"""
The grid height. This measumement is calculated at runtime, based on the parent
container dimensions, so the game world can scale dynamically.
"""
onready var grid_height: int = max(Grid.MINIMUM_HEIGHT, floor(rect_size.y / Grid.CELL_LENGTH)) as int


"""
The player's scored points.
"""
var score: int = 0


"""
Draw a rectangular frame around the playable game field.
"""
func _draw() -> void:
	var width := Grid.CELL_LENGTH * grid_width
	var height := Grid.CELL_LENGTH * grid_height
	draw_rect(Rect2(-1, -1, width + 2, height + 2), Color("#193300"))
	draw_rect(Rect2(0, 0, width, height), Color("#BFCC00"))


"""
Node initialization.
"""
func _ready() -> void:
	reset_snake()
	reset_food()

	$clock.start()


"""
Node input processing callback.
"""
func _input(event) -> void:
	if Input.is_action_just_pressed("ui_left"):
		$snake.turn_left()
	if Input.is_action_just_pressed("ui_right"):
		$snake.turn_right()


"""
Advances the game state every clock tick.
"""
func _on_clock_timeout() -> void:
	var next_cell: Vector2 = $snake.get_next_cell()
	if $food.check_collision(next_cell):
		$snake.add_segment(next_cell)
		reset_food()
	else:
		$snake.move()


"""
Changes the direction of the snake when the game is running.
"""
func turn_left() -> void:
	if is_game_running():
		$snake.turn_left()


"""
Changes the direction of the snake when the game is running.
"""
func turn_right() -> void:
	if is_game_running():
		$snake.turn_right()


"""
Pauses the game.
"""
func pause() -> void:
	$clock.paused = not $clock.paused


"""
Indicates if game is apt to respond to input events.
"""
func is_game_running() -> bool:
	return not ($clock.is_paused() or $clock.is_stopped())


"""
Build an array of grid cells to be queried later.
"""
func get_grid_cells() -> Array:
	var grid_cells := []
	for j in range(grid_height):
		for i in range(grid_width):
			grid_cells.push_back(Vector2(i, j))
	return grid_cells


"""
Get a random coordinate on the grid to spawn the snake.
"""
func get_random_grid_cell(margin: int) -> Vector2:
	var x := margin + randi() % (grid_width - 2 * margin)
	var y := margin + randi() % (grid_height - 2 * margin)
	return Vector2(x, y)


"""
Increase the game speed.
"""
func decrease_clock_delay() -> void:
	if $clock.wait_time > 0.08:
		$clock.wait_time -= 0.02


"""
Initializes the snake on the grid.
"""
func reset_snake() -> void:
	$snake.grid_width = grid_width
	$snake.grid_height = grid_height
	$snake.initialize(5, get_random_grid_cell(5), $snake.get_random_direction())


"""
Places the food on a free grid cell.
"""
func reset_food() -> void:
	var grid_cells := get_grid_cells()
	$snake.remove_occupied_cells(grid_cells)
	$food.cell = grid_cells[randi() % len(grid_cells)]


"""
Signal callback: stops the game when the snake runs over itself.
"""
func snake_died() -> void:
	$clock.stop()
	emit_signal("game_over")


"""
Signal callback: score 5 points for every piece of food eaten.
For every 30 points scored, the game speed increases.
"""
func snake_ate_food() -> void:
	score += 5

	if score % 30 == 0:
		decrease_clock_delay()

	emit_signal("score_updated", score)

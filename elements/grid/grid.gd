"""
Grid
====

Where all game action happens.

You can play the game in its minimal form typing [F6] to test it. Use [←] and
[→] keys to change direction.
"""
extends Node2D


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
The following fields expose the grid dimensions so they can be customized using
the Inspector.
"""
export (int) var grid_width
export (int) var grid_height


"""
The side length of each grid unit.
"""
const CELL_LENGTH = 16


"""
An array of orthogonal directions. Used to initialize the snake on the grid.
"""
const DIRECTIONS = [
	Vector2(0, -1),    # NORTH or UP
	Vector2(0, 1),     # SOUTH or DOWN
	Vector2(-1, 0),    # WEST  or LEFT
	Vector2(1, 0),     # EAST  or RIGHT
]


"""
The player's scored points.
"""
var score = 0


"""
Draw a frame around the playable game field.
"""
func _draw():
	var width = CELL_LENGTH * grid_width
	var height = CELL_LENGTH * grid_height
	draw_rect(Rect2(-1, -1, width + 2, height + 2), Color("#193300"))
	draw_rect(Rect2(0, 0, width, height), Color("#BFCC00"))


"""
Node initialization.
"""
func _ready():
	$Snake.initialize(5, get_random_grid_position(5), get_random_direction())
	$Food.place($Snake.get_free_cells())	
	$Clock.start()


"""
Node update process.
"""
func _process(delta):
	if is_running():
		if Input.is_action_just_pressed("ui_left"):
			$Snake.turn_left()
		if Input.is_action_just_pressed("ui_right"):
			$Snake.turn_right()


"""
Advances the game state every clock tick.
"""
func _on_clock_timeout():
	var new_head = $Snake.get_new_head()
	if $Food.check_collision(new_head):
		$Snake.add_segment(new_head)
		$Food.place($Snake.get_free_cells())
	else:
		$Snake.move()

"""
Changes the direction of the snake when the game is running.
"""
func turn_left():
	if is_running():
		$Snake.turn_left()


"""
Changes the direction of the snake when the game is running.
"""
func turn_right():
	if is_running():
		$Snake.turn_right()


"""
Pauses the game.
"""
func pause():
	$Clock.paused = not $Clock.paused


"""
Indicates if game is apt to respond to input events.
"""
func is_running():
	return not ($Clock.is_paused() or $Clock.is_stopped())


"""
Get a random coordinate on the grid to spawn the snake.
"""
func get_random_grid_position(margin):
	var x = margin + randi() % (grid_width - 2 * margin)
	var y = margin + randi() % (grid_height - 2 * margin)

	return Vector2(x, y)


"""
Get a random direction to face the snake towards.
"""
func get_random_direction():
	return DIRECTIONS[randi() % len(DIRECTIONS)]


"""
Increase the game speed.
"""
func decrease_clock_delay():
	if $Clock.wait_time > 0.08:
		$Clock.wait_time -= 0.02

"""
Signal callback: stops the game when the snake runs over itself.
"""
func snake_died():
	$Clock.stop()
	emit_signal("game_over")


"""
Signal callback: score 5 points for every piece of food eaten.
For every 30 points scored, the game speed increases.
"""
func snake_ate_food():
	score += 5
	
	if score % 30 == 0:
		decrease_clock_delay()

	emit_signal("score_updated", score)

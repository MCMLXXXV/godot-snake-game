"""
Snake
=====

The snake is composed of several body segments, and a new one is added for every
eaten piece of food.
"""
extends Node2D


"""
Emitted, well, when the snake dies. Game over!
"""
signal died


"""
The packed scene object containing the sprite of a single body segment.
Whenever a new segment is added to the snake body, a new sprite is created and
added as a child of this scene.
"""
export (PackedScene) var Segment


"""
This node needs to be instantiated inside the grid. The following three field
values are taken from the Grid scene and are required to calculate the
coordinates of body segments and position of sprites on this scene.
"""
onready var grid_width = get_parent().grid_width
onready var grid_height = get_parent().grid_height


"""
The snake "updates" every time it moves around the grid. This flag exists to
avoid the player tapping the rotation button twice, preventing the snake from
running over itself, ending the game sooner that intended.

Keep in mind this game is **not** using four-way movement logic to move the
snake around the grid, unlike most other implementations do. Some
implementations employ a different method to forbid the player choosing the
wrong direction, at the expense of more input validation.
"""
var updated = false


"""
An array of body segments coordinates. Each coordinate is a `Vector2` object.
"""
var segments = []


"""
The initial direction the snake should move towards. Will be overriden on
initialization.
"""
var direction = Vector2(1, 0)


"""
Places the snake on the grid with a desired number of initial body segments,
starting at the given grid position and orientend towards the given direction.
"""
func initialize(initial_segments, initial_grid_cell, initial_direction):
	direction = initial_direction
	for i in range(0, initial_segments):
		add_segment(initial_grid_cell)
		initial_grid_cell += direction


"""
Appends a new body segment to the front of the queue, making it the head of the
snake.
"""
func add_segment(position):
	var sprite = Segment.instance()
	sprite.position = position * Const.CELL_LENGTH

	segments.push_front(position)

	add_child(sprite)


"""
Updates the direction the snake will move to an adjacent coordinate, rotated 90°
to the left.
"""
func turn_left():
	if updated:
		direction = Vector2(direction.y, -direction.x)
		updated = false


"""
Updates the direction the snake will move to an adjacent coordinate, rotated 90°
to the right.
"""
func turn_right():
	if updated:
		direction = Vector2(-direction.y, direction.x)
		updated = false


"""
Returns the coordinate of the head of the snake, that is, the first `Vector2` on
the `segments` queue.
"""
func get_head():
	return segments.front()


"""
Calculates the cell where the head of the snake will move next. Takes care of
wrapping around the edges of the grid when necessary.
"""
func get_new_head():
	var head = get_head()
	var new_head = Vector2()

	new_head.x = wrapf(head.x + direction.x, 0, grid_width)
	new_head.y = wrapf(head.y + direction.y, 0, grid_height)

	return new_head


"""
Move the snake one step in the grid.
"""
func move():
	segments.push_front(get_new_head())
	segments.pop_back()

	if not check_self_collision():
		update_segments()
		updated = true


"""
Updates the sprites of the body segments on the grid.
"""
func update_segments():
	var sprites = get_children()

	for i in len(segments):
		var sprite = sprites[i]
		var segment = segments[i]
		sprite.position = Const.CELL_LENGTH * segment


"""
Creates an array of cells not occupied by the snake on the grid.
"""
func get_free_cells():
	var free_cells = []

	for i in range(grid_height):
		for j in range(grid_width):
			var cell = Vector2(j, i)
			if not cell in segments:
				free_cells.append(cell)

	if free_cells.empty():
		# The snake is covering the whole grid!
		emit_signal("died")

	return free_cells


"""
Checks if the head of the snake ran over its own body.
"""
func check_self_collision():
	if len(segments) > 4:
		var head = segments[0]
		for i in range(4, len(segments)):
			if head == segments[i]:
				emit_signal("died")
				return true
	return false

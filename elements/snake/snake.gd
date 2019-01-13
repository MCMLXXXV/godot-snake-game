"""
Snake
=====

The snake is composed of several body segments, and a new one is added for every
eaten piece of food.
"""
extends Node2D


"""
Emitted when the snake bites itself. Game over!
"""
signal died


"""
An array of orthogonal directions. Used to initialize the snake on the grid.
"""
const DIRECTIONS = [
	Vector2(0, -1),    # NORTH or UP
	Vector2(1, 0),     # EAST  or RIGHT
	Vector2(0, 1),     # SOUTH or DOWN
	Vector2(-1, 0),    # WEST  or LEFT
]


"""
The packed scene object containing the sprite of a single body segment.
Whenever a new segment is added to the snake body, a new sprite is created and
added as a child node of this scene.
"""
export (PackedScene) var Segment


"""
The world grid width. Must be a value greater than zero.
"""
var grid_width: int = Grid.MINIMUM_WIDTH setget set_grid_width


"""
The world grid height. Must be a value greater than zero.
"""
var grid_height: int = Grid.MINIMUM_HEIGHT setget set_grid_height


"""
The snake "updates" every time it moves around the grid. This flag exists to
avoid the player tapping the rotation button twice, preventing the snake from
running over itself, ending the game sooner that intended.

Keep in mind this game is **not** using four-way movement logic to move the
snake around the grid, unlike most other implementations do. Some
implementations employ a different method to forbid the player choosing the
wrong direction, at the expense of more input validation.
"""
var updated: bool = false


"""
The initial direction the snake should move towards. Will be overriden on
initialization.
"""
var direction: Vector2 = Vector2(1, 0)


"""
Places the snake on the grid with a desired number of initial body segments,
starting at the given grid position and orientend towards the given direction.
"""
func initialize(length: int, cell: Vector2, initial_direction: Vector2) -> void:
	direction = initial_direction
	for i in range(length):
		add_segment(cell)
		cell += direction


"""
Appends a new body segment to the front of the queue, making it the head of the
snake.
"""
func add_segment(cell: Vector2 = Vector2()) -> Segment:
	var segment = Segment.instance()
	segment.cell = cell

	add_child(segment)
	move_child(segment, 0)

	return segment


"""
Updates the direction the snake will move to an adjacent coordinate, rotated 90°
to the left.
"""
func turn_left() -> void:
	if updated:
		direction = Vector2(direction.y, -direction.x)
		updated = false


"""
Updates the direction the snake will move to an adjacent coordinate, rotated 90°
to the right.
"""
func turn_right() -> void:
	if updated:
		direction = Vector2(-direction.y, direction.x)
		updated = false


"""
Returns the head of the snake, that is, the `Segment` sprite at the top of the
children node list.
"""
func get_head() -> Segment:
	return get_child(0) as Segment


"""
Calculates the cell where the head of the snake will move next. Takes care of
wrapping around the edges of the grid when necessary.
"""
func get_next_cell() -> Vector2:
	var head_cell = get_head().cell
	var next_cell = Vector2()

	next_cell.x = wrapf(head_cell.x + direction.x, 0, grid_width)
	next_cell.y = wrapf(head_cell.y + direction.y, 0, grid_height)

	return next_cell


"""
Get a random direction to face the snake.
"""
func get_random_direction():
	return DIRECTIONS[randi() % len(DIRECTIONS)]


"""
Move the snake one step in the grid.
"""
func move() -> void:
	var next_cell = get_next_cell()

	if will_collide(next_cell):
		emit_signal('died')
		return

	for segment in get_children():
		var last_cell = segment.cell

		segment.cell = next_cell
		next_cell = last_cell

	updated = true


"""
Removes occupied cells from a grid cell table.
"""
func remove_occupied_cells(grid_cells) -> void:
	for segment in get_children():
		grid_cells.erase(segment.cell)

	if grid_cells.empty():
		# It seems that the snake is covering the whole grid!
		emit_signal("died")


"""
Checks if the snake will run over its own body.
"""
func will_collide(cell: Vector2) -> bool:
	var count = get_child_count()
	# Ignore if the snake is too small.
	if count > 4:
		# Do not check for a collision against the tail, to avoid ending the game
		# when the snake is chasing it.
		for i in range(3, count - 1):
			if get_child(i).will_collide(cell):
				return true
	return false


"""
`grid_width` property setter.
"""
func set_grid_width(value: int) -> void:
	grid_width = value if value >= Grid.MINIMUM_WIDTH else Grid.MINIMUM_WIDTH


"""
`grid_height` property setter.
"""
func set_grid_height(value: int) -> void:
	grid_height = value if value >= Grid.MINIMUM_HEIGHT else Grid.MINIMUM_HEIGHT

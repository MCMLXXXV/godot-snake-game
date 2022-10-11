## The snake, composed of several body segments - a new one is added each time
## it eats a piece of food.
extends Node2D

## The packed scene, containing the sprite of a single body segment.
## A new sprite is added as a child node of this scene, whenever a new segment
## is added to the body.
@onready
var segment_scene: PackedScene = get_meta("segment_scene")

## The direction the snake is moving towards.
var direction: Vector2i

## Prevent the snake changing its direction more than once before it has
## properly advanced one cell. Checked to validate player input.
var has_moved: bool


## Appends a new body segment, making it the head of the snake by default.
func add_segment(cell: Vector2i, is_head: bool = true) -> void:
	var sprite := segment_scene.instantiate()
	sprite.cell = cell
	add_child(sprite)
	if is_head:
		move_child(sprite, 0)


## Returns the cell where the head of the snake should move next. Takes care of
## wrapping around the edges of the grid when needed.
func get_next_cell(grid_width: int, grid_height: int) -> Vector2i:
	var cell: Vector2i = get_child(0).cell
	var x := wrapi(cell.x + direction.x, 0, grid_width)
	var y := wrapi(cell.y + direction.y, 0, grid_height)
	return Vector2i(x, y)


## Returns the list of cells occupied by the snake body on the grid.
func get_occupied_cells() -> Array[Vector2i]:
	return get_children().map(func(n): return n.cell)


## Places the snake on the grid with the desired number of initial segments,
## starting at the given grid cell and facing the given direction.
func initialize(size: int, starting_cell: Vector2i, starting_direction: Vector2i) -> void:
	direction = starting_direction
	for _i in size:
		add_segment(starting_cell, false)
		starting_cell -= direction


## Sets the direction of the snake 90 degress to the left.
func turn_left() -> void:
	if has_moved:
		direction = Vector2i(direction.y, -direction.x)
		has_moved = false


## Sets the direction of the snake 90 degress to the right.
func turn_right() -> void:
	if has_moved:
		direction = Vector2i(-direction.y, direction.x)
		has_moved = false


## Moves the snake to the given grid cell.
func walk(cell: Vector2i) -> void:
	var tail := get_child(-1)
	tail.cell = cell
	move_child(tail, 0)
	has_moved = true


## Checks if the snake will run over its body.
func will_collide(cell: Vector2i) -> bool:
	# Check only from the 4th segment onwards; avoid checking
	# a collision with the tail while chasing it.
	return get_children().slice(3, -1).any(func(n): return n.cell == cell)

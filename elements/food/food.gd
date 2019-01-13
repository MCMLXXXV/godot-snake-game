"""
Food
====

The piece of food sprite.
"""
extends Sprite


"""
Emitted when the snake eats food.
"""
signal eaten


"""
The minimum position this segment can occupy on the grid.
"""
const MINIMUM_CELL: Vector2 = Vector2()


"""
The grid cell this piece of food occupies on the grid.
"""
var cell: Vector2 = Vector2() setget set_cell


"""
Checks if the snake head collides with this piece of food.
"""
func check_collision(snake_head) -> bool:
	var collided = cell == snake_head
	if collided:
		emit_signal("eaten")

	return collided


"""
`cell` property setter
"""
func set_cell(value) -> void:
	cell = value if value >= MINIMUM_CELL else MINIMUM_CELL

	# Make sure the sprite is always updated accordingly.
	position = Const.CELL_LENGTH * cell

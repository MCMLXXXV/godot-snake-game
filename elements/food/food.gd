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
The grid cell this piece of food occupies on the grid.
"""
var cell: Vector2 = Grid.TOPLEFT_CELL setget set_cell


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
	cell = value if value >= Grid.TOPLEFT_CELL else Grid.TOPLEFT_CELL

	# Make sure the sprite is always updated accordingly.
	position = Grid.CELL_LENGTH * cell

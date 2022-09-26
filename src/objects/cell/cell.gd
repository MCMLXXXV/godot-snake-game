## A generic grid element.
extends Sprite2D

## This grid cell size.
const CELL_SIZE: int = 16


## The grid cell this piece of food occupies on the grid.
var cell: Vector2i = Vector2i.ZERO:
	set(value):
		cell = value if value >= Vector2i.ZERO else Vector2i.ZERO
		# Make sure the sprite is always updated accordingly.
		position = CELL_SIZE * cell

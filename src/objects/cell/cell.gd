## A generic grid element.
extends Sprite

## This grid cell size.
const CELL_SIZE: int = 16

## The grid cell this piece of food occupies on the grid.
var cell: Vector2 = Vector2.ZERO setget set_cell


## Sets this cell position on the grid.
func set_cell(value: Vector2) -> void:
	cell = value if value >= Vector2.ZERO else Vector2.ZERO
	# Make sure the sprite is always updated accordingly.
	position = CELL_SIZE * cell

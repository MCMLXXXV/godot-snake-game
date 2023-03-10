## A generic grid element.
extends Sprite

## This grid cell size.
const CELL_SIZE: int = 16

## The coordinates this cell occupies on the grid.
var cell: Vector2 = Vector2.ZERO setget set_cell

## Sets this cell position on the grid.
func set_cell(value: Vector2) -> void:
	cell = value
	# Make sure the sprite is always updated accordingly.
	position = CELL_SIZE * cell

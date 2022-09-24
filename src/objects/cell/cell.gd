## A generic grid element.
class_name Cell
extends Sprite


## The grid cell this piece of food occupies on the grid.
var cell: Vector2 = Vector2.ZERO setget set_cell


## Returns [code]true[/code] if this cell overlaps with another one.
func is_same_cell(other: Vector2) -> bool:
	return cell == other


## Sets this cell position on the grid.
func set_cell(value: Vector2) -> void:
	cell = value if value >= Vector2.ZERO else Vector2.ZERO
	# Make sure the sprite is always updated accordingly.
	position = Grid.CELL_SIZE * cell

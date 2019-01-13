"""
Segment
=======

A single snake body segment.
"""
class_name Segment
extends Sprite


"""
The cell this segment ocupies on the grid.
"""
var cell: Vector2 = Grid.TOPLEFT_CELL setget set_cell


"""
Checks collision against another body segment.
"""
func will_collide(another_cell: Vector2) -> bool:
	return cell == another_cell


"""
`cell` property setter.
"""
func set_cell(value: Vector2) -> void:
	cell = value if not value < Grid.TOPLEFT_CELL else Grid.TOPLEFT_CELL

	# Make sure the sprite is always updated accordingly.
	position = Grid.CELL_LENGTH * cell

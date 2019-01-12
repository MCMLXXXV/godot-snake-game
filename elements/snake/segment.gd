"""
Segment
=======

A single snake body segment.
"""
class_name Segment
extends Sprite


"""
The minimum position this segment can occupy on the grid.
"""
const MINIMUM_CELL: Vector2 = Vector2()


"""
The cell this segment ocupies on the grid.
"""
var cell: Vector2 = MINIMUM_CELL setget set_cell


"""
Checks collision against another body segment.
"""
func will_collide(another_cell: Vector2) -> bool:
	return cell == another_cell


"""
`cell` property setter.
"""
func set_cell(value: Vector2) -> void:
	cell = value if not value < MINIMUM_CELL else MINIMUM_CELL

	# Make sure the sprite is always updated accordingly.
	position = Const.CELL_LENGTH * cell

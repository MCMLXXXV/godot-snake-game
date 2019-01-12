"""
Const
=====

A script containing definitions of constant values used throughout the game
code.
"""
class_name Const
extends Node


"""
The side length of a grid cell.
"""
const CELL_LENGTH: int = 16


"""
An array of orthogonal directions. Used to initialize the snake on the grid.
"""
const DIRECTIONS = [
	Vector2(0, -1),    # NORTH or UP
	Vector2(0, 1),     # SOUTH or DOWN
	Vector2(-1, 0),    # WEST  or LEFT
	Vector2(1, 0),     # EAST  or RIGHT
]

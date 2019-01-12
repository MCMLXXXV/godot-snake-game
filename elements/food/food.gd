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
var grid_cell = Vector2()


"""
Pick a random free cell to place the food.
"""
func place(free_cells):
	if free_cells.empty():
		return

	var total = len(free_cells)
	var index = randi() % total

	grid_cell = free_cells[index]
	position = grid_cell * Const.CELL_LENGTH


"""
Checks if the snake head collides with this piece of food.
"""
func check_collision(snake_head):
	var collided = grid_cell == snake_head
	if collided:
		emit_signal("eaten")

	return collided

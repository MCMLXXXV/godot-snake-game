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
This node needs to be instantiated inside the grid. The following three field
values are taken from the Grid scene and are required to calculate the
coordinates on the grid and the sprite position.
"""
onready var grid_width = get_parent().grid_width
onready var grid_height = get_parent().grid_height
onready var cell_length = get_parent().CELL_LENGTH


"""
The position on the grid this food occupies.
"""
var grid_position = Vector2()


"""
Pick a random free cell to place the food.
"""
func place(free_cells):
	if not free_cells.empty():
		var total = len(free_cells)
		var index = randi() % total
		
		grid_position = free_cells[index]
		position = grid_position * cell_length


"""
Checks if the snake head collides with this piece of food.
"""
func check_collision(snake_head):
	var collided = grid_position == snake_head
	if collided:
		emit_signal("eaten")
	
	return collided

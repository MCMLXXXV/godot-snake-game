"""
Title
=====

The title screen UI. Just displays last session's high score and allows the
player to start the game with a single tap.
"""
extends MarginContainer


"""
Input processing. Nothing fancy, just start the game with a single screen tap,
or with the click of the mouse.
"""
func _input(event):
	if event is InputEventScreenTouch:
		start_game()


"""
Change to the Game scene.
"""
func start_game():
	get_tree().change_scene("res://ui/game/game.tscn")

"""
Title
=====

The title screen UI. Just displays last session's high score and allows the
player to start the game with a single tap.
"""
extends MarginContainer


"""
Start button callback: Change to the Game scene.
"""
func start_game():
	get_tree().change_scene("res://ui/game/game.tscn")


"""
Quit button callback: quit game, close application window.
"""
func quit():
	get_tree().quit()

"""
Title
=====

The title screen UI. Just displays last session's high score and allows the
player to start the game with a single tap.
"""
extends MarginContainer


func _ready() -> void:
	$vbox/hbox/vbox/score_label.set_points(Global.high_score)


"""
Start button callback: Change to the Game scene.
"""
func start_game() -> void:
	get_tree().change_scene("res://scenes/game/game.tscn")


"""
Quit button callback: quit game, close application window.
"""
func quit() -> void:
	get_tree().quit()

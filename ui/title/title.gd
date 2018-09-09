"""
Title
=====

The title screen UI. Just displays last session's high score and allows the
player to start the game with a single tap.
"""
extends MarginContainer


"""
Quick retrieve of the high score label on start up.
"""
onready var high_score_label = $CenterContainer/HBoxContainer/VerticalContainer/HighScoreLabel


"""
Updates the high score label with the actual value.
"""
func _ready():
	high_score_label.text = high_score_label.text % [Global.high_score]


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

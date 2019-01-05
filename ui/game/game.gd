"""
Game
====

Manages the Game screen UI.
"""
extends Node


"""
Quick retrieval of a few UI elements.
"""
onready var grid = $MarginContainer/Layout/GridContainer/Grid
onready var animation = $AnimationPlayer
onready var score_label = $MarginContainer/Layout/Header/Points
onready var game_over_label = $MarginContainer/Layout/Header/GameOverLabel


"""
Signal callback. Updates the displayed game score.
"""
func update_score(points):
	score_label.text = "%d" % [points]


"""
Callback of the game over signal.
"""
func game_over():
	game_over_label.show()
	animation.play("blink-score")
	Global.high_score = grid.score
	yield(get_tree().create_timer(3.0), "timeout")
	go_to_title_screen()


"""
Change the game to the title screen.
"""
func go_to_title_screen():
	get_tree().change_scene("res://ui/title/title.tscn")

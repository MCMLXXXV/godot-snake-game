"""
Game
====

Manages the Game screen UI.
"""
extends MarginContainer


"""
Quick retrieval of a few UI elements.
"""
onready var grid = $main_layout/grid_container/grid
onready var animation = $animation_player
onready var score_label = $main_layout/header/points
onready var game_over_label = $main_layout/header/game_over_label


"""
Signal callback. Updates the displayed game score.
"""
func update_score(points):
	score_label.text = "%d" % [points]


"""
Callback of the game over signal.
"""
func game_over():
	animation.play("blink-game-over")
	Global.high_score = grid.score
	yield(get_tree().create_timer(3.0), "timeout")
	go_to_title_screen()


"""
Change the game to the title screen.
"""
func go_to_title_screen():
	get_tree().change_scene("res://ui/title/title.tscn")

"""
Game
====

Manages the Game screen UI.
"""
extends MarginContainer


"""
Quick retrieval of a few UI elements.
"""
onready var grid: Control = $main_layout/grid_container/grid
onready var score_label: Label = $main_layout/header/score_label
onready var game_over_label: Label = $main_layout/header/game_over_label


"""
Signal callback. Updates the displayed game score.
"""
func update_score(points: int) -> void:
	score_label.set_points(points)


"""
Callback of the game over signal.
"""
func game_over() -> void:
	game_over_label.animate()
	Global.high_score = grid.score
	yield(get_tree().create_timer(3.0), "timeout")
	go_to_title_screen()


"""
Change the game to the title screen.
"""
func go_to_title_screen() -> void:
	get_tree().change_scene("res://scenes/title/title.tscn")

"""
HighScoreLabel
==============

Shows the last game high score.
"""
extends HBoxContainer


func set_points(value: int) -> void:
	$value_label.text = str(value)

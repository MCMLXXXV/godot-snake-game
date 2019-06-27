"""
HighScoreLabel
==============

Shows the last game high score.
"""
extends Label


"""
This label's text string format.
"""
const LABEL_TEXT: String = "HIGH SCORE\n%d POINTS"


"""
Updates the label with the last high score value.
"""
func _ready() -> void:
	text = LABEL_TEXT % [Global.high_score]

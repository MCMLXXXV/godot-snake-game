"""
Global
======

Initializes the pseudo-random number generator (PRNG) state and provides easy
access to last game's high score.
"""
extends Node


"""
Emitted when the last game's score is higher than the one currently stored.
"""
signal high_score_updated


"""
Stores the highest points the player ever scored. Can only be updated if the
new value is greater than the current one.
"""
var high_score: int = 0 setget set_high_score


"""
Retrieves the high score value and initializes the PRNG on initialization.
"""
func _ready() -> void:
	randomize()
	load_high_score()

	# Connect to the `high_score_updated` signal to save the data file.
	connect("high_score_updated", self, "save_high_score")


"""
Retrieves last session's high score.
"""
func load_high_score() -> void:
	high_score = Settings.get_value("game", "high_score", 0)


"""
Signal callback. Stores the game's highest scored points for future retrieval.
"""
func save_high_score() -> void:
	Settings.set_value("game", "high_score", high_score)
	Settings.save_settings()


"""
Update the high score only if last game's was higher.
"""
func set_high_score(score) -> void:
	if score > high_score:
		high_score = score
		emit_signal("high_score_updated")

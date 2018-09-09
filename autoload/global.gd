"""
Global
======

A simple "autoload" script, for storing and retrieving a game's highest score
and initializing the pseudo-random number generator (PRNG) state.
"""
extends Node


"""
Emitted when the last game's score is higher than the one currently stored.
"""
signal high_score_updated


"""
The name of our save data file.
"""
const SAVEDATA_FILE = "user://high-score.json"


"""
Stores the highest points the player ever scored. Can only be updated if the new
value is greater than the current one.
"""
var high_score = 0 setget set_high_score


"""
Retrieves the high score value and initializes the PRNG on initialization.
"""
func _ready():
	randomize()
	load_high_score()
	
	# Connect to the `high_score_updated` signal to save the data file.
	connect("high_score_updated", self, "save_high_score")


"""
Retrieves last session's high score.
"""
func load_high_score():
	var file = File.new()
	
	# Bail out if there is no save data. Maybe first game?
	if not file.file_exists(SAVEDATA_FILE):
		return
	
	file.open(SAVEDATA_FILE, File.READ)
	var data = JSON.parse(file.get_as_text()).result
	
	file.close()
	
	high_score = data["high_score"]


"""
Signal callback. Stores the game's highest scored points for future retrieval.
"""
func save_high_score():
	var data = { "high_score": high_score }
	var file = File.new()
	if file.open(SAVEDATA_FILE, File.WRITE) == OK:
		file.store_string(to_json(data))
		file.close()


"""
Update the high score only if last game's was higher.
"""
func set_high_score(score):
	if score > high_score:
		high_score = score
		emit_signal("high_score_updated")

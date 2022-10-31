## Keeps the game's global state.
extends Node

## The default high score value, if none is assigned.
const DEFAULT_HIGH_SCORE: int = 20

## Where the game record is saved.
const HIGH_SCORE_PATH: String = "user://high_score.json"

## Current game session score.
var score: int = 0:
	set(value):
		score = value
		if score > high_score:
			high_score = score

## This game's highest score recorded.
@onready
var high_score: int = load_high_score()


## Restores the high store value from the settings file.
func load_high_score() -> int:
	var data = Data.load_json(HIGH_SCORE_PATH)
	if data is Dictionary:
		var value = data.get("high_score")
		if value is float: # NOTE: JSON numbers are always `float`.
			return int(value)
	return DEFAULT_HIGH_SCORE


## Stores the high score value in the settings file.
func save_high_score() -> void:
	if high_score == score:
		Data.save_json(HIGH_SCORE_PATH, {high_score = high_score})

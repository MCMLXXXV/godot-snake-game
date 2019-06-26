"""
Application Constants
=====================

Constants and helper methods related to game application defaults.
"""
extends Object
class_name App


"""
Game settings file path, under Godot user's data directory.
"""
const GAME_SETTINGS_PATH: String = "user://game-settings.cfg"


"""
Default settings read and written by the application.
"""
const DEFAULT_SETTINGS: Dictionary = {
	"game": {
		"high_score": 0
	},
}

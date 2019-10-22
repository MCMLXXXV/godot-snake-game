"""
Settings
========

Manages application settings.
"""
extends Node


const CONFIG_KEY := "application/config/game_settings_path"


var game_settings_path: String = ProjectSettings.get(CONFIG_KEY)
var config_file := ConfigFile.new()


func _init() -> void:
	load_settings()


func load_settings() -> void:
	if config_file.load(game_settings_path) != OK:
		reset_settings()


func reset_settings() -> void:
	var settings := App.DEFAULT_SETTINGS
	for section in settings.keys():
		for key in settings[section].keys():
			config_file.set_value(section, key, settings[section][key])


func save_settings() -> void:
	config_file.save(game_settings_path)


func get_value(section, key, default):
	return config_file.get_value(section, key, default)


func set_value(section, key, value) -> void:
	config_file.set_value(section, key, value)

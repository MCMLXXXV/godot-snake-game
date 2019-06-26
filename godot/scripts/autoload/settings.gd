"""
Settings
========

Manages application settings.
"""
extends Node


var config_file := ConfigFile.new()


func _init() -> void:
	load_settings()


func load_settings() -> void:
	if not config_file.load(App.GAME_SETTINGS_PATH) == OK:
		reset_settings()


func reset_settings() -> void:
	var settings := App.DEFAULT_SETTINGS
	for section in settings.keys():
		for key in settings[section].keys():
			config_file.set_value(section, key, settings[section][key])


func save_settings() -> void:
	config_file.save(App.GAME_SETTINGS_PATH)


func get_value(section, key, default):
	return config_file.get_value(section, key, default)


func set_value(section, key, value) -> void:
	config_file.set_value(section, key, value)

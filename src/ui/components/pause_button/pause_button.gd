## A simple toggle button, with an alternating icon.
extends Button


func _on_toggled(value: bool) -> void:
	theme_type_variation = &"PlayButton" if value else &"PauseButton"

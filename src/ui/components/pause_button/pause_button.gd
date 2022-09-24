extends Button


func _get_button_icon(value = pressed) -> Texture:
	return theme.get_icon("play" if value else "pause", "Icons")


func _on_toggled(value: bool) -> void:
	icon = _get_button_icon(value)


func _ready() -> void:
	icon = _get_button_icon()

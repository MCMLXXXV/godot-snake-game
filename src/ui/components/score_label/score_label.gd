## Points components
##
## Displays the game score, with a custom label.
tool
extends HBoxContainer

export(int, 0, 9999) var count: int = 0 setget set_count, get_count
export var label: String = "Points" setget set_label, get_label


func blink_count() -> void:
	$Animations.play("blink")


func get_count() -> int:
	return count


func get_label() -> String:
	return label


func set_count(value: int) -> void:
	count = int(clamp(value, 0, 9999))
	$Count.text = str(count)


func set_label(value: String) -> void:
	label = value
	$Label.text = label

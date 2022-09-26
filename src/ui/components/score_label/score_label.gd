## Displays the game score, with a custom label.
@tool
extends HBoxContainer

@export_range(0, 9999, 1)
var count: int = 0:
	set(value):
		count = value
		$Count.text = str(value)


@export
var label: String = "Points":
	set(value):
		label = value
		$Heading.text = label


func blink_count() -> void:
	$Animations.play("blink")

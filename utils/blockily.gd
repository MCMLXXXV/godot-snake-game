## Generates the "Blockily" monospace bitmap font resource.
tool
extends EditorScript

const BASE_CHAR := 0x20 # ASCII number for the Space character
const CHAR_HEIGHT := 16
const CHAR_WIDTH := 16
const FONT_NAME := "Blockily"
const NUM_CHARACTERS := 63
const OUTPUT := "res://src/resources/fonts/blockily.tres"
const SRC := preload("res://assets/fonts/blockily.png")


static func get_character_bounds(index: int) -> Rect2:
	var x := index % CHAR_WIDTH * CHAR_WIDTH
	var y := index / CHAR_WIDTH % CHAR_HEIGHT * CHAR_HEIGHT
	return Rect2(x, y, CHAR_WIDTH, CHAR_HEIGHT)


func _run() -> void:
	var resource := BitmapFont.new()
	resource.resource_name = FONT_NAME
	resource.height = CHAR_HEIGHT
	resource.add_texture(SRC)
	for i in NUM_CHARACTERS:
		resource.add_char(BASE_CHAR + i, 0, get_character_bounds(i))
	ResourceSaver.save(OUTPUT, resource)

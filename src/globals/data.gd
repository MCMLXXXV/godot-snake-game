## Saves and retrieves JSON file data.
extends Node


## Loads the data from a given JSON file.
static func load_json(filename: String, default: Variant = null) -> Variant:
	if FileAccess.file_exists(filename):
		var file := FileAccess.open(filename, FileAccess.READ)
		if FileAccess.get_open_error() == OK:
			var json := JSON.new()
			if json.parse(file.get_as_text()) == OK:
				return json.get_data()
	return default


## Saves the data to the given JSON file.
static func save_json(filename: String, data: Variant) -> void:
	var file := FileAccess.open(filename, FileAccess.WRITE)
	if FileAccess.get_open_error() == OK:
		file.store_string(JSON.stringify(data))

## Saves and retrieves JSON file data.
extends Node


## Loads the data from a given JSON file.
static func load_json(json_path: String, default = null):
	var result = default
	if File.file_exists(json_path):
		var file := File.new()
		if file.open(json_path, File.READ) == OK:
			var json := JSON.new()
			if json.parse(file.get_as_text()) == OK:
				result = json.get_data()
			file.close()
	return result


## Saves the data to the given JSON file.
static func save_json(json_path: String, data) -> void:
	var file := File.new()
	if file.open(json_path, File.WRITE) == OK:
		file.store_string(JSON.stringify(data))
		file.close()

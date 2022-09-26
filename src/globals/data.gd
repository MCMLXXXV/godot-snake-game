## Saves and retrieves JSON file data.
extends Node


## Loads the data from a given JSON file.
static func load_json(json_path: String, default = null):
	var result = default
	var file := File.new()
	if file.file_exists(json_path) and file.open(json_path, File.READ) == OK:
		var parsed_json := JSON.parse(file.get_as_text())
		if parsed_json.error == OK:
			result = parsed_json.result
		file.close()
	return result


## Saves the data to the given JSON file.
static func save_json(json_path: String, data) -> void:
	var file := File.new()
	if file.open(json_path, File.WRITE) == OK:
		file.store_string(JSON.print(data))
		file.close()

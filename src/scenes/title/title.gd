extends MarginContainer


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	get_tree().change_scene("res://src/scenes/game/game.tscn")


func _ready() -> void:
	$"%HighScore".count = Global.high_score

extends MarginContainer


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/game/game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _ready() -> void:
	%HighScore.count = Global.high_score

extends MarginContainer


func _on_timer_timeout() -> void:
	get_tree().change_scene("res://src/scenes/title/title.tscn")


func _ready() -> void:
	$"%Points".count = Global.score

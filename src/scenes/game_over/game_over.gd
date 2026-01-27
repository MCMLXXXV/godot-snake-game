extends MarginContainer


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("uid://1loh58o2usjj")


func _ready() -> void:
	%Points.count = Global.score

"""
Game Over Label
===============
"""
extends Label


func animate() -> void:
	$animation.play("blink")


func stop_animation() -> void:
	$animation.stop()

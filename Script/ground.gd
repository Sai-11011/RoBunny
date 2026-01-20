extends Node2D

var Neon = Color(255,255,255)

func _on_timer_timeout() -> void:
	Neon = Color(randf(),randf(),randf())
	colorChange()

func colorChange():
	$background.color = Neon
	$Label.modulate = Neon

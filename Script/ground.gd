extends Node2D

var neon = Color(255,255,255)

func _on_timer_timeout() -> void:
	neon = Color(randf(),randf(),randf())
	Global.neon = neon
	colorChange()

func colorChange():
	$background.color = neon
	$Label.modulate = neon
	

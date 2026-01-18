extends Node2D

func _on_timer_timeout() -> void:
	$background.color = Color(randf(),randf(),randf())

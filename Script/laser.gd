extends Area2D

func _physics_process(delta: float) -> void:
	position.x += 1000*delta
	if position.x >= 350:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("glass"):
		queue_free()

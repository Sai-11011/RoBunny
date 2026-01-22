extends Area2D

func _process(delta: float) -> void:
	position.x -= delta*150


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		queue_free()
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == "rabbit":
		queue_free()
		

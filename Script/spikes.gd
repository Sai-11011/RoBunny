extends Area2D

@export var speed = 150

func _process(delta: float) -> void:
	position.x -= delta*speed
	if position.x <= -650:
		queue_free()



func _on_body_entered(body: Node2D) -> void:
		if body.name == "rabbit": 
			queue_free()

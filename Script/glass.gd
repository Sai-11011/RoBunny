extends Area2D

@export var speed = 150


func _process(delta: float) -> void:
	position.x -= delta*speed
	if position.x <= -650:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		area.queue_free()
		var Break = $CollisionShape2D/Break
		Break.play("break-by-bullet")
		await Break.animation_finished
		queue_free()
		
func _on_body_entered(body: Node2D) -> void:
	if body.name == "rabbit":
		var Break = $CollisionShape2D/Break
		$CollisionShape2D.set_deferred("disabled", true)
		Break.play("break-by-body")
		get_parent().take_damage()
		await Break.animation_finished
		queue_free()
		

extends Area2D

@export var speed = 150
var is_broken = false # Logic flag to prevent double hits
const Particals : PackedScene= preload("res://Scenes/glass_particals.tscn")

func _process(delta: float) -> void:
	position.x -= delta * speed
	if position.x <= -650:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if is_broken: return # Don't break twice
	
	if area.is_in_group("bullets"):
		is_broken = true
		$CollisionShape2D.set_deferred("disabled", true) # Turn off collision immediately
		$AudioStreamPlayer2D.play()
		area.queue_free() # Delete bullet
		spawn_particals()
		var Break = $CollisionShape2D/Break
		Break.play("break-by-bullet")
		await Break.animation_finished
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if is_broken: return # Don't hurt player if already breaking
	
	if body.name == "rabbit":
		is_broken = true
		$CollisionShape2D.set_deferred("disabled", true) # Turn off collision immediately
		$AudioStreamPlayer2D.play()
		
		var Break = $CollisionShape2D/Break
		Break.play("break-by-body")
		spawn_particals()
		get_parent().take_damage() # Hurt player
		
		await Break.animation_finished
		queue_free()

#Glass parts animation
func spawn_particals():
	var parts = Particals.instantiate()
	parts.global_position= global_position
	get_parent().add_child(parts)
	

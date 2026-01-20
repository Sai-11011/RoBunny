extends Node2D

const Glass : PackedScene = preload("res://Scenes/glass.tscn")

func _physics_process(delta: float) -> void:
	$ground.position.x -= 150*delta
	if $ground.position.x <= -960:
		$ground.position.x = -320


func _on_timer_timeout() -> void:
	var glass = Glass.instantiate()
	glass.position = Vector2(330,-200)
	get_parent().add_child(glass)

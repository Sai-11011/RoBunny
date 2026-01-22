extends Node2D

var score = 0

const Glass : PackedScene = preload("res://Scenes/glass.tscn")

func _physics_process(delta: float) -> void:
	$background/ground.position.x -= 150*delta
	if $background/ground.position.x <= -960:
		$background/ground.position.x = -320
	update_score()


func _on_timer_timeout() -> void:
	var glass = Glass.instantiate()
	glass.position = Vector2(330,-200)
	get_parent().add_child(glass)

#score logic
func _on_score_timeout() -> void:
	score += 1

func update_score():
	$score.text = str(score)

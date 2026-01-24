extends Node2D

var score = 0

const Glass : PackedScene = preload("res://Scenes/glass.tscn")
const Spikes : PackedScene = preload("res://Scenes/spikes.tscn")

var currentSpeed = 150

func _physics_process(delta: float) -> void:
	$background/ground.position.x -= currentSpeed*delta
	if $background/ground.position.x <= -960:
		$background/ground.position.x = -320
	update_score()

func _on_timer_timeout() -> void:
	if randf()<0.5:
		var spikes = Spikes.instantiate()
		spikes.position = Vector2(360,160)
		spikes.scale = Vector2(0.3,0.3)
		spikes.speed = currentSpeed
		add_child(spikes)
	else:
		var glass = Glass.instantiate()
		glass.position = Vector2(330,-200)
		glass.speed = currentSpeed
		add_child(glass)

#score logic
func _on_score_timeout() -> void:
	score += 1
	currentSpeed += 1

func update_score():
	$score.text = str(score)

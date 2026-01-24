extends Node2D

var score = 0
var lives = 3

const Glass : PackedScene = preload("res://Scenes/glass.tscn")
const Spikes : PackedScene = preload("res://Scenes/spikes.tscn")

var currentSpeed = 150
var heartBreak = "night" 

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

#lives logic
func take_damage():
	lives -= 1
	update_lives()


func update_lives():
	var heart_to_remove = null
	
	# 1. Pick the heart
	if lives == 2:
		heart_to_remove = $extra/hearts3
	elif lives == 1:
		heart_to_remove = $extra/hearts2
	elif lives == 0:
		heart_to_remove = $extra/hearts
	
	# 2. Play animation and wait for signal
	if heart_to_remove:
		heart_to_remove.play(heartBreak) 
		await heart_to_remove.animation_finished 
		heart_to_remove.queue_free()
		if lives == 0:
			game_over()


func game_over():
	get_tree().paused = true


#score logic
func _on_score_timeout() -> void:
	score += 1
	currentSpeed += 1

func update_score():
	$extra/score.text = str(score)

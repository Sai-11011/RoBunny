extends Node2D

var score = 0
var lives = 3

const Glass : PackedScene = preload("res://Scenes/glass.tscn")
const Spikes : PackedScene = preload("res://Scenes/spikes.tscn")

var currentSpeed = 150

# start logic
func _ready() -> void:
	# 1. Reset Audio State
	AudioManager.stop_game_over() # Stop sad music if it's still playing
	AudioManager.play_bgm()       # Force BGM to start (because Autoload won't do it on restart)
	
	# 2. Pause the game setup
	get_tree().paused = true 
	$CanvasLayer/Start/HighScore.text = "High-Score : "+str(Global.score)

func _on_start_button_pressed() -> void:
	$CanvasLayer/Start.visible = false
	print($CanvasLayer/Start.visible)
	get_tree().paused = false

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
		glass.position = Vector2(330,-130)
		glass.speed = currentSpeed
		add_child(glass)

#lives logic
func take_damage():
	if lives <= 0:return
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
		heart_to_remove.play_break()
		AudioManager.play_heart_break()
		
		await heart_to_remove.animation_finished 
		heart_to_remove.queue_free()
		if lives == 0:
			game_over()

#score logic
func _on_score_timeout() -> void:
	score += 1
	currentSpeed += 1

func update_score():
	$extra/score.text = str(score)

#game loop
func game_over():
	AudioManager.play_game_over()
	get_tree().paused = true
	if Global.score < score:
		Global.score = score
		Global.save_score()
	$CanvasLayer/gameOverUI/score.text ="Score : "+str(score)
	$CanvasLayer/gameOverUI/HighScore.text = "High-Score : "+str(Global.score)
	$CanvasLayer/gameOverUI.visible = true

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	$CanvasLayer/Start/HighScore.text = "High-Score : "+str(Global.score)

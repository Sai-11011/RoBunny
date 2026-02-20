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
	AudioManager.toggle_sfx(Global.sound_on)
	AudioManager.toggle_music(Global.music_on)
	update_button_visuals()
	
	if Global.instant_restart:
		$CanvasLayer/Start.visible = false
		get_tree().paused = false # Start immediately!
		Global.instant_restart = false
		
	else:
		get_tree().paused = true 
		$CanvasLayer/Start/HighScore.text = "High-Score : "+str(Global.score)


func _on_start_button_pressed() -> void:
	AudioManager.play_ui_click()
	$CanvasLayer/Start.visible = false
	print($CanvasLayer/Start.visible)
	get_tree().paused = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and lives > 0:   
		toggle_pause()
	$background/ground.position.x -= currentSpeed*delta
	if $background/ground.position.x <= -960:
		$background/ground.position.x = -320
	update_score()

func _on_timer_timeout() -> void:
	if randf()>0.55:
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
		Global.save_data()
	$CanvasLayer/gameOverUI/score.text ="Score : "+str(score)
	$CanvasLayer/gameOverUI/HighScore.text = "High-Score : "+str(Global.score)
	$CanvasLayer/gameOverUI.visible = true

func _on_restart_button_pressed() -> void:
	AudioManager.play_ui_click()
	Global.instant_restart = true
	get_tree().paused = false
	get_tree().reload_current_scene()
	$CanvasLayer/Start/HighScore.text = "High-Score : "+str(Global.score)

func toggle_pause():
	var is_paused = get_tree().paused
	get_tree().paused = not is_paused
	$CanvasLayer/PauseMenu.visible = not is_paused
	AudioManager.play_ui_click()
	

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	$CanvasLayer/Start/HighScore.text = "High-Score : "+str(Global.score)


func _on_resume_pressed() -> void:
	get_tree().paused = false
	$CanvasLayer/PauseMenu.visible = false


func _on_sound_toggled(toggled_on: bool) -> void:
	Global.sound_on = toggled_on
	AudioManager.toggle_sfx(toggled_on)
	Global.save_data()
	update_button_visuals()

func _on_music_toggled(toggled_on: bool) -> void:
	Global.music_on = toggled_on
	AudioManager.toggle_music(toggled_on)
	Global.save_data()
	update_button_visuals()

func update_button_visuals():
	var s = Global.sound_on
	var m = Global.music_on
	
	$CanvasLayer/Start/Sound.set_pressed_no_signal(s)
	$CanvasLayer/PauseMenu/Sound.set_pressed_no_signal(s)
	$CanvasLayer/gameOverUI/Sound.set_pressed_no_signal(s)
	
	$CanvasLayer/Start/Music.set_pressed_no_signal(m)
	$CanvasLayer/PauseMenu/Music.set_pressed_no_signal(m)
	$CanvasLayer/gameOverUI/Music.set_pressed_no_signal(m)

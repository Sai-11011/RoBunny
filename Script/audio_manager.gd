extends Node

# Play specific sounds by calling these functions directly
func _ready() -> void:
	play_bgm()

func stop_game_over():
	$gameOver.stop()

func play_laser():
	# Randomized pitch makes it sound less repetitive
	$laser.pitch_scale = randf_range(0.9, 1.1)
	$laser.play()

func play_jump():
	$jump.play()

func play_glass_break():
	# Random pitch for variety
	$glassBreak.pitch_scale = randf_range(0.8, 1.2)
	$glassBreak.play()

func play_heart_break():
	$HeartBreak.play()

func play_game_over():
	$bgm.stop() 
	$gameOver.play()
	

func play_bgm():
	if not $bgm.playing:
		$bgm.play()

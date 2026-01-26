extends Node2D

# We create a custom signal so Main knows when we are done
signal animation_finished

func play_break():
	$heart.play() 
	
	if $outline.sprite_frames.has_animation("default"):
		$outline.play()
	
	# 3. Wait for the main heart animation to finish
	await $heart.animation_finished
	
	# 4. Tell the Main script "We are done!"
	animation_finished.emit()

extends Node2D

# We create a custom signal so Main knows when we are done
signal animation_finished

func play_break():
	$heart.play() 
	$outline.play()
	
	await $heart.animation_finished
	await $outline.animation_finished
	
	animation_finished.emit()

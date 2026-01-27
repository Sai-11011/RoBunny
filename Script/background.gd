extends ColorRect

var brightness = 0.0  # Start at 1.0 (White/Day)
var is_daytime = true # We are currently in day mode
var speed = 0.01       # How fast the sun sets (Lower = Slower)

func transition(delta):
	# If it is Day, we want to get Darker (Decrease brightness)
	if is_daytime:
		brightness -= speed * delta
		if brightness <= 0.0: # If fully black
			brightness = 0.0
			is_daytime = false # Switch to Night mode
			
	else:
		brightness += speed * delta
		if brightness >= Global.max_brightness: # If fully white
			brightness = Global.max_brightness
			is_daytime = true # Switch to Day mode

	color = Color(brightness, brightness, brightness)

func _process(delta: float) -> void:
	transition(delta)

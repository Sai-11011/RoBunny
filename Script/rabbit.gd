extends CharacterBody2D


const JUMP_VELOCITY = -600.0

func _physics_process(delta: float) -> void:
	# 1. Apply Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. Handle Jump Input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("shoot") :
		$CollisionShape2D/bullet.emitting = true
	
	
	# 3. Handle Animation (The Fix)
	if is_on_floor():
		# We are on the ground, so we should be running
		$CollisionShape2D/JumpAnimation.play("run") 
	else:
		# We are in the air, so play the jump animation
		$CollisionShape2D/JumpAnimation.play("runjump")

	move_and_slide()

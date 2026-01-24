extends CharacterBody2D

const BulletScene : PackedScene = preload("res://Scenes/laser.tscn")
const GunPosition = Vector2(-162,129)
const JUMP_VELOCITY = -500.0
 
func _physics_process(delta: float) -> void:
	# 1. Apply Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. Handle Jump Input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("shoot") and is_on_floor():
		var laser = BulletScene.instantiate()
		laser.position = GunPosition
		$laser.play()
		get_parent().add_child(laser)
		
	if is_on_floor():
		$JumpAnimation.play("run") 
	else:
		$JumpAnimation.play("Jump")

	move_and_slide()

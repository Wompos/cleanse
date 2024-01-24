extends CharacterBody2D


var speed = -150.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if !$FloorDetectL.is_colliding() || !$FloorDetectR.is_colliding():
		speed = speed * -1
	
	if $WallDetectL.is_colliding() || $WallDetectR.is_colliding():
		speed = speed * -1
	
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
	velocity.x = speed
	move_and_slide()


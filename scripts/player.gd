#TO DO
#Make walls sticky
#Make double jump animation work properly
#Make wall jumping propel you away from the wall

extends CharacterBody2D
const SPEED = 200.0
const JUMP_VELOCITY = -350.0
const ACCEL = 25.0
const W_slide = 25.0
const WALL_JUMP_VELOCITY = -200.0
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var double_jump = true
var facing = true
@onready var raycastBL = $RayCastBL
@onready var raycastTL = $RayCastTL
@onready var raycastBR = $RayCastBR
@onready var raycastTR = $RayCastTR
@onready var raycastBR2 = $RayCastBR2
@onready var raycastBL2 = $RayCastBL2

@onready var healthText = $Health
@onready var respawnTimer = $RespawnTimer

@export var max_health : float = 3
@export var start_pos : Vector2 = Vector2(411, 593)

var health = max_health
var last_velocity = Vector2(0, 0)

func _ready():
	healthText.bbcode_enabled = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if health <= 0:
		velocity.x = move_toward(velocity.x, 0, ACCEL)
	else:
		# Handle jump.
		how_to_jump()

		#Get the input direction and handle the movement/deceleration.
		if Input.is_action_pressed("move_left") && Input.is_action_pressed("move_right"):
			velocity.x = move_toward(velocity.x, 0, ACCEL)
		elif Input.is_action_pressed("move_right"):
			velocity.x = min(velocity.x + 25, SPEED)
		elif Input.is_action_pressed("move_left"):
			velocity.x = max(velocity.x - 25, -SPEED)
		else:
			velocity.x = move_toward(velocity.x, 0, ACCEL)
		
		# Wall jumping
		if real_is_on_wall() && not is_on_floor() && velocity.y > 0:
			velocity.y = W_slide
			
		# Check for damage
		if velocity.y == 0 and last_velocity.y >= 500:
			velocity.x = -200 if sprite_2d.flip_h else 200
			velocity.y = -100
			health -= 1
		
		if position.y > 1000:
			reset()
	
	#Handle animation.
	pick_animation()
		
	if health == 0 and respawnTimer.is_stopped():
		respawnTimer.start(5)
	
	# Save last velocity
	last_velocity = Vector2(velocity.x, velocity.y)
	healthText.text = "[center]" + str(health) + "[/center]"
	
	move_and_slide()

func reset():
	position.x = start_pos.x
	position.y = start_pos.y
	velocity.y = 0
	health = max_health
	respawnTimer.stop()
	
func pick_animation():
	if health == 0:
		sprite_2d.animation = "die"
	else:
		if is_on_floor():
			if (velocity.x < 0 || velocity.x > 0):
				sprite_2d.animation = "running"
			else:
				sprite_2d.animation = "default"

		if not is_on_floor():
			if (velocity.y < 0 && double_jump == false):
				sprite_2d.animation = "double_jump"
			elif (velocity.y < 0):
				sprite_2d.animation = "jumping"
			else:
				sprite_2d.animation = "falling"
		
		if not is_on_floor() && real_is_on_wall():
			sprite_2d.animation = "wall_jump"
	
	if velocity.x > 0:
		sprite_2d.flip_h = false
		
	if velocity.x < 0:
		sprite_2d.flip_h = true

func how_to_jump():
	if is_on_floor():
		double_jump = true
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("jump") and real_is_on_wall():
		velocity.y = WALL_JUMP_VELOCITY
	
	if !real_is_on_wall():
		if raycastBR.is_colliding() and !raycastBR2.is_colliding() and Input.is_action_pressed("move_right"):
			velocity.x = 100.0
			velocity.y = -120.0
		if raycastBL.is_colliding() and !raycastBL2.is_colliding() and Input.is_action_pressed("move_left"):
			velocity.x = -100.0
			velocity.y = -120.0
	
	if Input.is_action_just_pressed("jump") and real_is_on_wall() and !is_on_floor():
		if sprite_2d.flip_h:
			velocity.x = 500.0
		else:
			velocity.x = -500.0
	elif Input.is_action_just_pressed("jump") and double_jump and !is_on_floor():
		velocity.y = JUMP_VELOCITY
		double_jump = false
	
	if Input.is_action_just_released("jump") && (velocity.y < -125):
		velocity.y = -125

func real_is_on_wall():
	return raycastTL.is_colliding() != raycastTR.is_colliding()

func _on_respawn_timer_timeout():
	reset()

#extends Node

extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d:Sprite2D = $Sprite2D

const SPEED:int = 260.0
const JUMP_VELOCITY: int = -350.0

var jumps: int = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		# if the player is falling then increase the gravity by 1.4 
		#; this is done to make the movement less floaty
		if(velocity.y >= 0):
			velocity.y += gravity * 1.4 * delta
		else:
			velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#cut the jump short mid air
	if Input.is_action_just_released("jump") and velocity.y < -150:
		velocity.y /= 6

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animation_player.play("run")
		if(direction > 0):
			sprite_2d.scale.x = sprite_2d.scale.y
		else:
			sprite_2d.scale.x = sprite_2d.scale.y * -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation_player.play("idle")
	
	if(not is_on_floor()):
		if(velocity.y >= JUMP_VELOCITY and velocity.y <= -100):
			animation_player.play("jump_start")
		if(velocity.y >= -100 and velocity.y <= 100):
			animation_player.play("jump_mid")
		if(velocity.y >= -100):
			animation_player.play("jump_end")

	move_and_slide()

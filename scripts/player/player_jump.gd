extends State

const JUMP_VELOCITY: float = -350.0
var animation_player : AnimationPlayer
var sprite_2d : Sprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED:float = 160.0

func enter():
	animation_player = parent.get_node('AnimationPlayer')
	sprite_2d = parent.get_node('Sprite2D')
	parent.velocity.y += JUMP_VELOCITY
	if(parent.get_node("Controller/PlayerActionStateMachine").current_state.name.to_lower() == "none"):
		animation_player.play("jump_start")

func process_physics(delta):
	parent.velocity.y += gravity * delta
	
	if parent.velocity.y >= - 100 && parent.get_node("Controller/PlayerActionStateMachine").current_state.name.to_lower() == "none":
		animation_player.play("jump_mid")
	
	if parent.velocity.y > 0:
		SignalBus.player_movement_state_change.emit(self,"fall")
		
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		parent.velocity.x = direction * SPEED
		if(direction > 0):
			sprite_2d.scale.x = sprite_2d.scale.y
		else:
			sprite_2d.scale.x = sprite_2d.scale.y * -1
		

func process_input(event : InputEvent):
	if Input.is_action_just_released("jump") and parent.velocity.y < -150:
		parent.velocity.y /= 5
	

func _on_entered_none():
	if parent.velocity.y >= - 100:
		animation_player.play("jump_mid")
	else:
		animation_player.play("jump_start")

extends State

var animation_player : AnimationPlayer
var sprite_2d : Sprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED:float = 160.0


func enter():
	animation_player = parent.get_node('AnimationPlayer')
	sprite_2d = parent.get_node('Sprite2D')
	if(parent.get_node("Controller/PlayerActionStateMachine").current_state.name.to_lower() == "none"):
		animation_player.play("jump_end")

func process_physics(delta):
	parent.velocity.y += gravity * delta * 1.3
		
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
			parent.velocity.x = direction * SPEED
			if(direction > 0):
				sprite_2d.scale.x = sprite_2d.scale.y
			else:
				sprite_2d.scale.x = sprite_2d.scale.y * -1
	
	if parent.is_on_floor():
		if direction:
			#return move_state
			SignalBus.player_movement_state_change.emit(self, "run")
		else:
			#return idle_state
			SignalBus.player_movement_state_change.emit(self, "idle")
	

func _on_entered_none():
	animation_player.play("jump_end")

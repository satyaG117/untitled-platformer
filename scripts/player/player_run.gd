extends State

var animation_player : AnimationPlayer
var sprite_2d : Sprite2D
const SPEED:float = 200.0

func enter():
	animation_player = parent.get_node('AnimationPlayer')
	sprite_2d = parent.get_node('Sprite2D')
	if(parent.get_node("Controller/PlayerActionStateMachine").current_state.name.to_lower() == "none"):
		animation_player.play("run")
	

func process_physics(delta):
	if(not parent.is_on_floor()):
		SignalBus.player_movement_state_change.emit(self, "fall");
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		parent.velocity.x = direction * SPEED
		if(direction > 0):
			sprite_2d.scale.x = sprite_2d.scale.y
		else:
			sprite_2d.scale.x = sprite_2d.scale.y * -1
	else:
		SignalBus.player_movement_state_change.emit(self, "idle")

func process_input(event : InputEvent):
		if Input.is_action_just_pressed('jump') and parent.is_on_floor():
			SignalBus.player_movement_state_change.emit(self , "jump");

func _on_entered_none():
	animation_player.play("run")

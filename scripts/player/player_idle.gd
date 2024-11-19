extends State

const SPEED:float = 260.0
var animation_player : AnimationPlayer

func enter():
	animation_player = parent.get_node('AnimationPlayer')
	if(parent.get_node("Controller/PlayerActionStateMachine").current_state.name.to_lower() == "none"):
		animation_player.play("idle")
	#parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)
	parent.velocity.x = 0

func process_physics(delta):
	if(not parent.is_on_floor()):
		SignalBus.player_movement_state_change.emit(self, "fall");

func process_input(event : InputEvent):
		if Input.is_action_just_pressed('jump') and parent.is_on_floor():
			SignalBus.player_movement_state_change.emit(self , "jump");
		if Input.is_action_just_pressed('move_left') or Input.is_action_just_pressed('move_right'):
			SignalBus.player_movement_state_change.emit(self, "run");

func _on_entered_none():
	parent.get_node('AnimationPlayer').play('idle')
	

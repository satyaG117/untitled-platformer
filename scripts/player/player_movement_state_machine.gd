extends StateMachine

@export var player_action_SM : StateMachine

func init(parent : CharacterBody2D):
	#print(parent)
	super(parent)
	#connect the signal to the signal handler in parent class
	SignalBus.player_movement_state_change.connect(handle_state_transition)
	SignalBus.player_entered_none.connect(_on_player_entered_none)


func _on_player_entered_none():
	if(current_state and current_state.has_method("_on_entered_none")):
		current_state._on_entered_none();

func process_input(event : InputEvent):
	if(current_state):
		current_state.process_input(event)


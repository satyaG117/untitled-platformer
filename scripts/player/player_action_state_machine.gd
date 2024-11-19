extends StateMachine

func init(parent : CharacterBody2D):
	#print(parent)
	super(parent)
	#connect the signal to the signal handler in parent class
	SignalBus.player_action_state_change.connect(handle_state_transition)

func process_input(event : InputEvent):
	if(current_state):
		current_state.process_input(event)


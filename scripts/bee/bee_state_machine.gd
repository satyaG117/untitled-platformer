extends StateMachine

func init(parent : CharacterBody2D):
	#print(parent)
	super(parent)
	#connect the signal to the signal handler in parent class
	SignalBus.bee_state_change.connect(handle_state_transition)

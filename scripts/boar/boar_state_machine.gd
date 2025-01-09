extends StateMachine

func init(parent):
	super(parent)
	print("Boar state machine initiated")
	SignalBus.boar_state_change.connect(handle_state_transition)

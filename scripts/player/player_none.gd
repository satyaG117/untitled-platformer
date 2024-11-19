extends State

func enter():
	SignalBus.player_entered_none.emit()

func process_input(event : InputEvent):
	if(Input.is_action_just_pressed("meele_attack")):
		SignalBus.player_action_state_change.emit(self, "attack")


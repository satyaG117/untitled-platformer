extends State

var animation_player : AnimationPlayer
var player_movement_SM : StateMachine
var attack_selection : int

func enter():
	animation_player = parent.get_node("AnimationPlayer")
	player_movement_SM = parent.get_node("Controller/PlayerMovementStateMachine")
	
	if(player_movement_SM.current_state.name.to_lower() == "run"):
		animation_player.play("attack_1")
	else:
		#select one of attack 1 or 3 at random
		if (randi() % 2 == 0):
			attack_selection = 2
		else:
			attack_selection = 3
		
		animation_player.play("attack_"+str(attack_selection))


func handle_attack_end(animation_name):
	if(animation_name in ["attack_1" , "attack_2", "attack_3"]):
		SignalBus.player_action_state_change.emit(self, "none")


func _on_animation_player_animation_finished(anim_name):
	print(anim_name)
	handle_attack_end(anim_name)


func _on_animation_player_animation_changed(old_name, new_name):
	print(old_name + " -> " + new_name)
	handle_attack_end(old_name)

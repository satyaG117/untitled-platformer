extends State

var animation_player : AnimationPlayer

func enter():
	print("Bee attack")
	parent.velocity = Vector2.ZERO
	animation_player = parent.get_node("AnimationPlayer")
	animation_player.play("attack")


func handle_attack_end(animation_name):
	if(animation_name == "attack"):
		SignalBus.bee_state_change.emit(self, "cooldown")


func _on_animation_player_animation_finished(anim_name):
	handle_attack_end(anim_name)


func _on_animation_player_animation_changed(old_name, new_name):
	handle_attack_end(old_name)

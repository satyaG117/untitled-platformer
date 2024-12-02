extends State

var animation_player : AnimationPlayer

func enter():
	print("Bee hit")
	#parent.velocity = Vector2.ZERO
	animation_player = parent.get_node("AnimationPlayer")
	animation_player.play("hit")


#func handle_attack_end(animation_name):
	#if(animation_name == "hit"):
		#SignalBus.bee_state_change.emit(self, "idle")
#
#
#func _on_animation_player_animation_finished(anim_name):
	#handle_attack_end(anim_name)


#func _on_animation_player_animation_changed(old_name, new_name):
	#handle_attack_end(old_name)

func process_physics(delta):
	if parent.velocity.length() == 0:
		SignalBus.bee_state_change.emit(self, "idle")
	
	parent.velocity = parent.velocity.move_toward(Vector2.ZERO, delta * parent.weight * 75)

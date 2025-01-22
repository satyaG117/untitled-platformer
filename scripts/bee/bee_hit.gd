extends State

var animation_player : AnimationPlayer

func enter():
	print("Bee hit")
	#parent.velocity = Vector2.ZERO
	animation_player = parent.get_node("AnimationPlayer")
	animation_player.play("hit")



func process_physics(delta):
	if parent.velocity.length() == 0:
		SignalBus.bee_state_change.emit(self, "idle")
	
	parent.velocity = parent.velocity.move_toward(Vector2.ZERO, delta * parent.weight * 75)

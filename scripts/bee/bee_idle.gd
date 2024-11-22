extends State

var animation_player : AnimationPlayer
var frames_since_last_check : int = 0

func enter():
	print("Bee idle")
	parent.velocity = Vector2.ZERO
	animation_player = parent.get_node('AnimationPlayer');
	animation_player.play("fly");

func process_physics(delta):
	if(frames_since_last_check != 0):
		frames_since_last_check -= 1
	else:
		if(parent.global_position.distance_to(GlobalVariables.player.global_position) <= 200):
			SignalBus.bee_state_change.emit(self, "pursue")
		frames_since_last_check = 10
	

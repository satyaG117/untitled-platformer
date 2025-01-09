extends State

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_player : AnimationPlayer


func enter():
	print("Boar state : Fall")
	animation_player = parent.get_node('AnimationPlayer')
	animation_player.play('idle')

func process_physics(delta):
	print("fall")
	parent.velocity.y += gravity * delta
	if parent.is_on_floor():
		SignalBus.boar_state_change.emit(self, "patrol")

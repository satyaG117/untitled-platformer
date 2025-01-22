extends State

var animation_player : AnimationPlayer
@onready var cooldown_timer = $CooldownTimer

func enter():
	
	parent.velocity.x = 0
	animation_player = parent.get_node('AnimationPlayer')
	animation_player.play('idle')
	cooldown_timer.wait_time = randf_range(1.5, 2.5) 
	cooldown_timer.start()
	

func process_physics(delta):
	if(!parent.is_on_floor()):
		SignalBus.boar_state_change.emit(self, "fall")

func _on_cooldown_timer_timeout():
	SignalBus.boar_state_change.emit(self, "patrol")


func exit():
	cooldown_timer.stop()


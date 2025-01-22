extends State
var animation_player : AnimationPlayer
@onready var cooldown_timer = $CooldownTimer
var player_position : Vector2
var bee_position : Vector2
var audio_stream_player : CustomAudioStreamPlayer2D

func enter():
	print("Bee Cooldown")
	animation_player = parent.get_node('AnimationPlayer')
	animation_player.play('fly')
	
	audio_stream_player = parent.get_node("CustomAudioStreamPlayer2D")
	audio_stream_player.pitch_scale = 0.9
	audio_stream_player.load_stream("res://assets/audio/insect-buzzing.mp3")
	audio_stream_player.play()
	
	cooldown_timer.wait_time = randf_range(1.0, 2.0) 
	cooldown_timer.start()

func process_physics(delta):
	if(abs(GlobalVariables.player.global_position.x - parent.global_position.x) > 12 || 
			abs(GlobalVariables.player.global_position.y - parent.global_position.y) > 4):
				cooldown_timer.stop()
				SignalBus.bee_state_change.emit(self, "pursue")


func _on_cooldown_timer_timeout():
	if(abs(GlobalVariables.player.global_position.x - parent.global_position.x) > 12 || 
			abs(GlobalVariables.player.global_position.y - parent.global_position.y) > 4):
				SignalBus.bee_state_change.emit(self, "pursue")
	else:
		SignalBus.bee_state_change.emit(self, "attack")

func exit():
	audio_stream_player.reset()

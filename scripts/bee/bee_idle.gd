extends State

var animation_player : AnimationPlayer
var frames_since_last_check : int = 0
var audio_stream_player : CustomAudioStreamPlayer2D

func enter():
	parent.velocity = Vector2.ZERO
	animation_player = parent.get_node('AnimationPlayer');
	animation_player.play("fly");
	
	audio_stream_player = parent.get_node("CustomAudioStreamPlayer2D")
	audio_stream_player.pitch_scale = 0.8
	audio_stream_player.load_stream("res://assets/audio/insect-buzzing.mp3")
	audio_stream_player.play()
	

func process_physics(delta):
	if(frames_since_last_check != 0):
		frames_since_last_check -= 1
	else:
		if(parent.global_position.distance_to(GlobalVariables.player.global_position) <= 200):
			SignalBus.bee_state_change.emit(self, "pursue")
		frames_since_last_check = 10
	

func exit():
	audio_stream_player.reset()

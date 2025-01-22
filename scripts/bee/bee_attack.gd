extends State

var animation_player : AnimationPlayer
var audio_stream_player : CustomAudioStreamPlayer2D

func enter():
	print("Bee attack")
	parent.velocity = Vector2.ZERO
	animation_player = parent.get_node("AnimationPlayer")
	audio_stream_player = parent.get_node("CustomAudioStreamPlayer2D")
	audio_stream_player.pitch_scale = 1.5
	audio_stream_player.load_stream("res://assets/audio/insect-buzzing.mp3")
	
	animation_player.play("attack")
	audio_stream_player.play()

func handle_attack_end(animation_name):
	if(animation_name == "attack"):
		SignalBus.bee_state_change.emit(self, "cooldown")


func _on_animation_player_animation_finished(anim_name):
	handle_attack_end(anim_name)


#func _on_animation_player_animation_changed(old_name, new_name):
	#handle_attack_end(old_name)

func exit():
	animation_player.play("RESET")
	animation_player.advance(0)
	audio_stream_player.reset()

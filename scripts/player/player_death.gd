extends State

var animation_player : AnimationPlayer
var audio_stream_player

var player_death_sound_path : String = "res://assets/audio/female grunt.mp3"

func enter():
	animation_player = parent.get_node("AnimationPlayer")
	audio_stream_player = parent.get_node("CustomAudioStreamPlayer2D")
	audio_stream_player.load_stream(player_death_sound_path)
	audio_stream_player.play()
	animation_player.play("death");
	


func on_death_animation_finished(anim_name):
	if(anim_name == 'death'):
		get_tree().reload_current_scene()

func _on_animation_player_animation_changed(old_name, new_name):
	on_death_animation_finished(old_name)


func _on_animation_player_animation_finished(anim_name):
	on_death_animation_finished(anim_name)

func exit():
	audio_stream_player.reset()

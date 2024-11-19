extends State

var animation_player : AnimationPlayer

func enter():
	animation_player = parent.get_node("AnimationPlayer")
	animation_player.play("death");


func on_death_animation_finished(anim_name):
	if(anim_name == 'death'):
		get_tree().reload_current_scene()

func _on_animation_player_animation_changed(old_name, new_name):
	on_death_animation_finished(old_name)


func _on_animation_player_animation_finished(anim_name):
	on_death_animation_finished(anim_name)

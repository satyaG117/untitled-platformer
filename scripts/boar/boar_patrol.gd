extends State

const WALK_SPEED : float = 60
var ground_raycast : RayCast2D
var environment_raycast : RayCast2D
var player_raycast : RayCast2D
var sprite_2d : Sprite2D
var animation_player : AnimationPlayer
var audio_stream_player : CustomAudioStreamPlayer2D

func enter():
	ground_raycast = parent.get_node('Sprite2D/GroundRayCast')
	environment_raycast = parent.get_node('Sprite2D/EnvironmentRayCast')
	player_raycast = parent.get_node('Sprite2D/PlayerRayCast')
	sprite_2d = parent.get_node('Sprite2D')
	animation_player = parent.get_node('AnimationPlayer')
	audio_stream_player = parent.get_node('CustomAudioStreamPlayer2D')
	
	audio_stream_player.load_stream("res://assets/audio/horse walk.mp3")
	audio_stream_player.play()
	animation_player.play("walk")
	var direction = sprite_2d.scale.x
	parent.velocity.x = WALK_SPEED * direction * -1 # -1 is multiplied because the sprite points to the left by default
	


func process_physics(delta):
	if(!parent.is_on_floor()):
		SignalBus.boar_state_change.emit(self, "fall")
	
	#if wall is in the way or there is no ground further then turn around
	if(environment_raycast.is_colliding() || !ground_raycast.is_colliding()):
		sprite_2d.scale.x = sprite_2d.scale.x * -1
		parent.velocity.x = WALK_SPEED * sprite_2d.scale.x * -1
	
	if(player_raycast.is_colliding()):
		SignalBus.boar_state_change.emit(self, "charge")


func exit():
	audio_stream_player.reset()

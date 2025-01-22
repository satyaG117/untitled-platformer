extends State


const RUN_SPEED : float = 120
var ground_raycast : RayCast2D
var environment_raycast : RayCast2D
var sprite_2d : Sprite2D
var animation_player : AnimationPlayer
var audio_stream_player : CustomAudioStreamPlayer2D

func enter():
	ground_raycast = parent.get_node('Sprite2D/GroundRayCast')
	environment_raycast = parent.get_node('Sprite2D/EnvironmentRayCast')
	sprite_2d = parent.get_node('Sprite2D')
	animation_player = parent.get_node('AnimationPlayer')
	audio_stream_player = parent.get_node('CustomAudioStreamPlayer2D')
	
	audio_stream_player.load_stream("res://assets/audio/horse gallop.mp3")
	audio_stream_player.play()
	animation_player.play("charge")
	var direction = sprite_2d.scale.x
	parent.velocity.x = RUN_SPEED * direction * -1 # -1 is multiplied because the sprite points to the left by default
	


func process_physics(delta):
	if(environment_raycast.is_colliding()):
		print("Env raycast not colliding")
		SignalBus.boar_state_change.emit(self, "cooldown")
	if(!ground_raycast.is_colliding()):
		print("Ground raycast not colliding")
		SignalBus.boar_state_change.emit(self, "cooldown")
	
	if(!parent.is_on_floor()):
		SignalBus.boar_state_change.emit(self, "fall")

func exit():
	print("PLAYING RESET ANIMATION")
	animation_player.play('RESET')
	animation_player.advance(0)
	audio_stream_player.reset()

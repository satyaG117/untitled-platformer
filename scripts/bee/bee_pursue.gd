extends State
var animation_player : AnimationPlayer
var sprite_2d : Sprite2D
var frames_since_last_check : int = 0
var distance_from_player : float
var target_position :Vector2
var move_speed : float = 70.0
var current_player_position : Vector2
var bee_position : Vector2
var rng : RandomNumberGenerator

func enter():
	print("Bee pursue")
	animation_player = parent.get_node('AnimationPlayer')
	sprite_2d = parent.get_node('Sprite2D')
	animation_player.play("fly");
	rng = RandomNumberGenerator.new()
	

func process_physics(delta):
	if(frames_since_last_check != 0):
		frames_since_last_check -= 1
	else:
		current_player_position = GlobalVariables.player.global_position
		bee_position =  parent.global_position
		
		#rotate sprite based on player position
		if(current_player_position.x <= bee_position.x):
			sprite_2d.scale.x = sprite_2d.scale.y
		else:
			sprite_2d.scale.x = sprite_2d.scale.y * -1
		
		distance_from_player = bee_position.distance_to(current_player_position)
		
		#if target is far away then resort to idle start
		if(distance_from_player > 200):
			SignalBus.bee_state_change.emit(self, "idle")
		else:
			#create a target point
			var x = rng.randf_range(10, 12)
			var y = rng.randf_range(-4, 4)
			if(current_player_position.x <= bee_position.x):
				target_position.x = current_player_position.x + x
			else:
				target_position.x = current_player_position.x - x
			target_position.y = current_player_position.y + y
			# Calculate direction to target
			var direction = (target_position - bee_position).normalized()

			# Calculate velocity
			parent.velocity = direction * move_speed

			# Stop moving if close enough to the target
			if(abs(current_player_position.x - bee_position.x) <= 12 && 
			abs(current_player_position.y - bee_position.y) <= 4):
				SignalBus.bee_state_change.emit(self, "attack")
			 
		frames_since_last_check = 5

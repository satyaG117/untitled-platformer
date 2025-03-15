extends CharacterBody2D

@onready var animation_player_2 = $AnimationPlayer2
@onready var player_action_state_machine = $Controller/PlayerActionStateMachine
@onready var player_movement_state_machine = $Controller/PlayerMovementStateMachine
@onready var hurtbox_component = $HurtboxComponent
@onready var hitbox_component = $Sprite2D/HitboxComponent

var MAX_HEALTH : float = 100
var current_health : float = MAX_HEALTH
var is_player_input_disabled : bool = false;
var isInvincible : bool = false;
var weight : float = 30.0

func _ready():
	GlobalVariables.player = self
	player_action_state_machine.init(self)
	player_movement_state_machine.init(self)
	hurtbox_component.init(self)
	hitbox_component.init(self)
	
	SignalBus.player_instantiated.emit();
	

func _unhandled_input(event: InputEvent):
	if(is_player_input_disabled):
		return
	player_movement_state_machine.process_input(event)
	player_action_state_machine.process_input(event)
	

func _process(delta)-> void:
	player_movement_state_machine.process_frame(delta)
	player_action_state_machine.process_frame(delta)

func _physics_process(delta) -> void:
	player_movement_state_machine.process_physics(delta)
	player_action_state_machine.process_physics(delta)
	move_and_slide()

func set_invincible_status(status: bool):
	isInvincible = status

func die():
	is_player_input_disabled = true
	player_action_state_machine.force_transition('death')

func process_attack(attack):
	if(isInvincible && !attack.insta_kill):
		return
	
	
	current_health -= attack.damage
	SignalBus.player_hit.emit()
	Utility.hit_stop(0.15)
	animation_player_2.play("flash")
	if(current_health <= 0):
		die()


func process_healing(health_points : float):
	if(current_health == MAX_HEALTH):
		return;
	
	print("Inside player heal function")
	#variable = value1 if condition else value2
	print("Health before healing : ", current_health);
	current_health = MAX_HEALTH if current_health + health_points >= MAX_HEALTH else current_health + health_points
	print("Health after healing : ", current_health);
	SignalBus.player_heal.emit()

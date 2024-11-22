extends CharacterBody2D

@onready var player_action_state_machine = $Controller/PlayerActionStateMachine
@onready var player_movement_state_machine = $Controller/PlayerMovementStateMachine
@onready var hurtbox_component = $HurtboxComponent
var MAX_HEALTH : float = 100
var current_health : float = MAX_HEALTH
var is_player_input_disabled = false;

func _ready():
	GlobalVariables.player = self
	player_movement_state_machine.init(self)
	player_action_state_machine.init(self)
	hurtbox_component.init(self)
	
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


func die():
	is_player_input_disabled = true
	player_action_state_machine.force_transition('death')

func take_damage(damage):
	current_health -= damage
	if(current_health <= 0):
		die()


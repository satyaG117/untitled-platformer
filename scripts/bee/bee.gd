extends CharacterBody2D

@onready var hurtbox_component = $HurtboxComponent
@onready var bee_state_machine = $BeeStateMachine

var MAX_HEALTH : float = 20
var current_health : float = MAX_HEALTH

func _ready():
	hurtbox_component.init(self);
	bee_state_machine.init(self);
	
func _process(delta):
	bee_state_machine.process_frame(delta)

func _physics_process(delta):
	bee_state_machine.process_physics(delta)
	move_and_slide()

func die():
	queue_free()

func take_damage(damage):
	current_health -= damage
	if(current_health <= 0):
		die()

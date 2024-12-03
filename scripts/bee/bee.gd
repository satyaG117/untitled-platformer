extends CharacterBody2D

@onready var hurtbox_component = $HurtboxComponent
@onready var bee_state_machine = $BeeStateMachine
@onready var hitbox_component = $Sprite2D/HitboxComponent

var MAX_HEALTH : float = 20
var current_health : float = MAX_HEALTH
var weight : float = 20

func _ready():
	hurtbox_component.init(self);
	bee_state_machine.init(self);
	hitbox_component.init(self)
	
func _process(delta):
	bee_state_machine.process_frame(delta)

func _physics_process(delta):
	bee_state_machine.process_physics(delta)
	move_and_slide()

func die():
	queue_free()

func process_attack(attack : Attack):
	current_health -= attack.damage
	Utility.hit_stop(0.15)
	
	if(current_health <= 0):
		die()
	
	if(attack.knock_back && attack.knock_back > 0):
		velocity = (global_position - attack.origin).normalized() * attack.knock_back
	
	bee_state_machine.force_transition("hit")

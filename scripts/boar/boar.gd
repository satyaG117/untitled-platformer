extends CharacterBody2D

@onready var hitbox_component = $Sprite2D/HitboxComponent
@onready var hurtbox_component = $HurtboxComponent
@onready var boar_state_machine = $BoarStateMachine

const  MAX_HEALTH : float = 50
var current_health : float = MAX_HEALTH
const weight : float = 200

func _ready():
	hitbox_component.init(self)
	hurtbox_component.init(self)
	boar_state_machine.init(self)


func _process(delta):
	boar_state_machine.process_frame(delta)

func _physics_process(delta):
	boar_state_machine.process_physics(delta)
	move_and_slide()

func die():
	queue_free()

func process_attack(attack : Attack):
	current_health -= attack.damage
	Utility.hit_stop(0.15)
	
	if(current_health <= 0):
		die()

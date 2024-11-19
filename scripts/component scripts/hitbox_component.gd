extends Area2D

@export var damage : float = 0.0

func _on_area_entered(area):
	if(area.has_method("process_attack")):
		var attack = Attack.new()
		attack.damage = damage
		area.process_attack(attack)

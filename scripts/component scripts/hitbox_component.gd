extends Area2D

@export var damage : float = 0.0
@export var knock_back : float = 0.0
var parent

func init(parent):
	self.parent = parent

func _on_area_entered(area):
	if(area.has_method("process_attack")):
		var attack = Attack.new()
		attack.damage = damage
		attack.knock_back = knock_back
		attack.origin = parent.global_position
		
		area.process_attack(attack)

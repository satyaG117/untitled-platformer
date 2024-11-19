extends Area2D

var parent : Node2D

func init(parent: Node2D):
	self.parent = parent
	
func process_attack(attack : Attack):
	parent.take_damage(attack.damage)

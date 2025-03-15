extends Area2D

var parent : Node2D

func init(parent: Node2D):
	self.parent = parent
	
func process_attack(attack : Attack):
	parent.process_attack(attack)


func process_healing(healing_points : float):
	if(parent.has_method("process_healing")):
		parent.process_healing(healing_points)

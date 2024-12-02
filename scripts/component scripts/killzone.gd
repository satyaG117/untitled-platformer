extends Area2D

func _ready():
	print("Killzone ready")

func _on_area_entered(area):
	print("area entered")
	if(area.has_method("process_attack")):
		var attack = Attack.new()
		attack.damage = 9999
		attack.knock_back = 0.0
		attack.origin = Vector2.ZERO
		attack.insta_kill = true
		
		area.process_attack(attack)

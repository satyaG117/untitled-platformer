extends Area2D

@onready var animation_player = $AnimationPlayer

func _on_area_entered(area):
	animation_player.play("pickup")

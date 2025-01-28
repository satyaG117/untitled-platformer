extends Area2D
@onready var animation_player = $AnimationPlayer

func _ready():
	print(collision_mask)

func _on_area_entered(area : Area2D):
	print(area)
	SignalBus.coin_pickup.emit()
	animation_player.play("pickup")

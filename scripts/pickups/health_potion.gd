extends Area2D

@onready var animation_player = $AnimationPlayer
var healing_points : float = 15

func _ready():
	SignalBus.player_heal.connect(_on_player_heal)

func _on_area_entered(area):
	if(area.has_method("process_healing")):
		area.process_healing(healing_points)


func _on_player_heal():
	animation_player.play("pickup")

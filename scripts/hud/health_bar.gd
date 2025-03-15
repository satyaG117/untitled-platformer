extends ProgressBar
var player : CharacterBody2D
@onready var damage_bar = $DamageBar
@onready var timer = $DamageBar/Timer

func _ready():
	print("Health bar ready")
	if(GlobalVariables.player):
		max_value = GlobalVariables.player.MAX_HEALTH;
		value = GlobalVariables.player.MAX_HEALTH;
		damage_bar.max_value = GlobalVariables.player.MAX_HEALTH;
		damage_bar.value = GlobalVariables.player.MAX_HEALTH;

	#SignalBus.player_instantiated.connect(initialize_health_bar);
	SignalBus.player_hit.connect(_on_player_hit);
	SignalBus.player_heal.connect(_on_player_heal);
	
#func initialize_health_bar():
	#print("Health bar init")
	#max_value = GlobalVariables.player.MAX_HEALTH;
	#value = GlobalVariables.player.MAX_HEALTH;
	#damage_bar.max_value = GlobalVariables.player.MAX_HEALTH;
	#damage_bar.value = GlobalVariables.player.MAX_HEALTH;
#

func _on_player_heal():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", GlobalVariables.player.current_health , 0.15)
	tween.tween_property(damage_bar, "value", GlobalVariables.player.current_health , 0.15)
	

func _on_player_hit():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", GlobalVariables.player.current_health , 0.15)
	#value = GlobalVariables.player.current_health
	timer.start(0.35)



func _on_timer_timeout():
	print("Damage bar updated")
	var tween = get_tree().create_tween()
	tween.tween_property(damage_bar, "value", GlobalVariables.player.current_health , 0.15)
	#damage_bar.value = GlobalVariables.player.current_health

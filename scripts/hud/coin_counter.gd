extends CanvasLayer

var coins_count : int = 0
@onready var label = $Label

func _ready():
	SignalBus.coin_pickup.connect(_on_coin_pickup)
	label.text = ' x ' + str(0)
	
func _on_coin_pickup():
	coins_count += 1;
	label.text = ' x ' + str(coins_count)

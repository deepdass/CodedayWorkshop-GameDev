extends Control

@onready var player: Node3D = %Player
@onready var total_coin: Label = $TotalCoin

func _process(delta: float) -> void:
	total_coin.text = "1"

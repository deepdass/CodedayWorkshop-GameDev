extends Node3D

@export var CoinAmount : int = 1
@onready var timer: Timer = $Timer
@onready var area_3d: Area3D = $Area3D
@onready var coin: Node3D = $"."


func _on_area_3d_body_entered(body: Node3D) -> void:
	if (body.has_method("add_coin")):
		body.add_coin(CoinAmount)
		area_3d.set_deferred("monitoring", false)
		coin.visible = false
		timer.start()


func _on_timer_timeout() -> void:
	area_3d.set_deferred("monitoring", true)
	coin.visible = true

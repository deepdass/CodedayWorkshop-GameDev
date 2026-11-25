extends Node3D

@export var CoinAmount : int = 1
@onready var timer: Timer = $Timer
@onready var area_3d: Area3D = $Area3D
@onready var coin: Node3D = $"."

const hiteffect : PackedScene = preload("res://_AttackAssets/VFXs/Hiteffect/HitEffect.tscn")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if (body.has_method("add_coin")):
		body.add_coin(CoinAmount)
		area_3d.set_deferred("monitoring", false)
		coin.visible = false
		spawn_hiteffect()
		timer.start()


func _on_timer_timeout() -> void:
	area_3d.set_deferred("monitoring", true)
	coin.visible = true

func spawn_hiteffect() -> void:
	var hiteffect_inst : Node3D = hiteffect.instantiate()
	hiteffect_inst.position = position
	hiteffect_inst.scale = hiteffect_inst.scale * 10
	get_tree().get_current_scene().add_child(hiteffect_inst)

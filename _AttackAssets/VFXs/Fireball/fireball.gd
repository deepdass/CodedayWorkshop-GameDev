extends Node3D

const hiteffect : PackedScene = preload("res://_AttackAssets/VFXs/Hiteffect/HitEffect.tscn")

const projectile_speed : int = 15
var forward_direction : Vector3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	forward_direction = transform.basis.z
	global_translate(forward_direction * projectile_speed * delta)

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	
	if body.has_method("take_damage"):
		body.take_damage()
		
	queue_free()
	spawn_hiteffect()


func spawn_hiteffect() -> void:
	var hiteffect_inst : Node3D = hiteffect.instantiate()
	hiteffect_inst.position = position
	get_tree().get_current_scene().add_child(hiteffect_inst)

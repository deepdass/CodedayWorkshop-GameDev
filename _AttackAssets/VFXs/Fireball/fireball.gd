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
	
	var target_node = body.get_parent()
	if target_node and target_node.has_method("TargetEff"):
		target_node.TargetEff()
	
	if body is RigidBody3D:
		var dir : Vector3 = (body.global_position - global_position).normalized()
		body.apply_impulse(dir * 7000) #magic number: adjust force
		
	spawn_hiteffect()
	queue_free()


func spawn_hiteffect() -> void:
	var hiteffect_inst : Node3D = hiteffect.instantiate()
	hiteffect_inst.position = position
	get_tree().get_current_scene().add_child(hiteffect_inst)

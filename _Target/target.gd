extends Node3D

@export var angle_offset_deg: float = 90.0

@onready var animation_player: AnimationPlayer = $TargetMesh/AnimationPlayer

func TargetEff(direction: Vector3) -> void:
	direction.y = 0.0
	if direction.length() < 0.001:
		return
	direction = direction.normalized()
	global_rotation.y = atan2(-direction.x, -direction.z) + deg_to_rad(angle_offset_deg)
	animation_player.play("TargetHit")

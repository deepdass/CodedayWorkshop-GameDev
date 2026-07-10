extends Node3D

@onready var animation_player: AnimationPlayer = $MeshInstance3D/CameraPivot/AnimationPlayer


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.get_parent().is_in_group("Player"):
		animation_player.play("PanningToDoStuff")

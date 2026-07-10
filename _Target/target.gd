extends Node3D

@onready var animation_player: AnimationPlayer = $TargetMesh/AnimationPlayer

func TargetEff():
	animation_player.play("TargetHit")

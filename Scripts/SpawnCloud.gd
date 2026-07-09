extends Node3D

@export var cloud_scenes: Array[PackedScene]
@export var spawn_area: CollisionShape3D
@export var cloud_count: int = 20
@export var min_height: float = 5.0
@export var max_height: float = 30.0

func _ready() -> void:
	spawn_clouds()

func spawn_clouds() -> void:
	var box: BoxShape3D = spawn_area.shape
	var half_extents: Vector3 = box.size / 2.0
	var origin: Vector3 = spawn_area.global_transform.origin

	for i in cloud_count:
		var scene: PackedScene = cloud_scenes[randi() % cloud_scenes.size()]
		var cloud: Node3D = scene.instantiate()

		var x := randf_range(-half_extents.x, half_extents.x)
		var z := randf_range(-half_extents.z, half_extents.z)
		var y := randf_range(min_height, max_height)

		cloud.position = origin + Vector3(x, y, z)
		add_child(cloud)

extends Node

@onready var camera_pivot: Node3D = $"../Player/CameraPivot"
@onready var player: CharacterBody3D = $"../Player/MovementComp"

@onready var camera_3d: Camera3D = $"../Player/CameraPivot/Camera3D"
@onready var cam_initailpt: Node3D = $"../Player/CameraPivot/cam_Initailpt"
@onready var cam_finalpt: Node3D = $"../Player/CameraPivot/cam_finalpt"

@onready var sub_viewport: SubViewport = $"../.."
@onready var world : Node3D = $".."
var ray_origin : Vector3
var ray_target_pt : Vector3

@export var lag_speed: float = 5.0


func _process(delta: float) -> void:
	
	if (Input.is_action_just_pressed("ESC")):
		get_tree().quit()
		
	if (Input.is_action_just_pressed("Restart")):
		get_tree().reload_current_scene()
		
	#print(Engine.get_frames_per_second())


func _physics_process(delta: float) -> void:
	var weight = 1.0 - exp(-lag_speed * delta)
	var target = player.position
	camera_pivot.position = camera_pivot.position.lerp(target, weight)
	
	if Input.is_action_just_pressed("zoomIN"):
		camera_3d.position = camera_3d.position.move_toward(cam_initailpt.position, delta * 25)
		camera_3d.position = camera_3d.position.move_toward(cam_initailpt.position + Vector3(0,0.01,0.01), delta * 25)
	if Input.is_action_just_pressed("zoomOUT"):
		camera_3d.position = camera_3d.position.move_toward(cam_finalpt.position, delta * 25)
		camera_3d.position = camera_3d.position.move_toward(cam_finalpt.position - Vector3(0,0.01,0.01), delta * 25)
		
		
	var mouse_pos : Vector2 = sub_viewport.get_mouse_position()
	ray_origin = camera_3d.project_ray_origin(mouse_pos)
	ray_target_pt = ray_origin + camera_3d.project_ray_normal(mouse_pos) * 1000
	
	var space_state : PhysicsDirectSpaceState3D = world.get_world_3d().direct_space_state
	var params : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(ray_origin,ray_target_pt,1)
	params.exclude = [player]
	var intersection : Dictionary = space_state.intersect_ray(params)
	
	if not intersection.is_empty():
		var look_at_me : Vector3 = Vector3(intersection.position.x, player.position.y, intersection.position.z)
		player._rotate(look_at_me)

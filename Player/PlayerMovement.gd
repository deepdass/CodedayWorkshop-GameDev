extends CharacterBody3D


const SPEED = 17.0
const JUMP_VELOCITY = 3.4

@onready var visuals: Node3D = $Visuals

@export var IsMage : bool = false
@onready var car: Node3D = $Visuals/Car
@onready var mage: Node3D = $Visuals/Mage
@onready var animation_player: AnimationPlayer = $Visuals/Mage/AnimationPlayer
@onready var animation_player_car: AnimationPlayer = $Visuals/Car/catbanana/AnimationPlayer

func _ready() -> void:
	if IsMage:
		mage.visible = true
		car.visible = false
	else:
		car.visible = true
		mage.visible = false
		
		

func _process(delta: float) -> void:
	RenderingServer.global_shader_parameter_set("player_position", global_position)

func _physics_process(delta: float) -> void:
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		var target_rotation = atan2(direction.x, direction.z)
		visuals.rotation.y = lerp_angle(visuals.rotation.y, target_rotation, 8.0 * delta)
		
		if IsMage:
			animation_player.play("Walking_A")
		else:
			animation_player_car.play("metarigAction_001")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if IsMage:
			animation_player.play("Idle")
		else:
			animation_player_car.seek(0)
		
	move_and_slide()

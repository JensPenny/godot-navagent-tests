extends RigidBody2D

@onready var nav_agent = $NavigationAgent2D
@export var target: RigidBody2D = null
@export var speed: float = 300.0

var movement_delta # Just do this to be conform the tutorial

func _ready() -> void:
	nav_agent.debug_enabled = true
	nav_agent.avoidance_enabled = true
	nav_agent.avoidance_layers = 2
	nav_agent.avoidance_mask = 1
	nav_agent.velocity_computed.connect(Callable(_on_velocity_computed))
		
	# Configure RigidBody2D for proper navigation
	gravity_scale = 0.0
	lock_rotation = true
	linear_damp = 5.0  # Add some damping for smoother movement

	
func _process(_delta: float) -> void:
	nav_agent.target_position = target.global_position

func _physics_process(delta: float) -> void:
	if NavigationServer2D.map_get_iteration_id(nav_agent.get_navigation_map()) == 0:
		return
	if nav_agent.is_target_reached():
		print_debug("reached target")
		return

	movement_delta = delta * speed
	var next_position = nav_agent.get_next_path_position()
	# global_position.move_toward(next_position, movement_delta)
	var new_velocity = global_position.direction_to(next_position) * speed

	if nav_agent.avoidance_enabled:
		nav_agent.velocity = new_velocity
	else: 
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	linear_velocity = safe_velocity
	# if movement_delta != null:
	# 	global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)

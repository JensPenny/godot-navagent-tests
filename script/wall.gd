class_name Wall
extends Node2D

@onready var obstacle = $NavigationObstacle2D
@onready var sprite = $Sprite2D

var wall_manager: Wall_Manager = null

func _ready() -> void:
	obstacle.avoidance_enabled = true
	obstacle.avoidance_layers = 1
	# The obstacle uses vertices (polygon shape) defined in the scene
	# No need to set radius as it's using a custom polygon shape

func _input(event: InputEvent) -> void:
	#remove a wall if there is a right-click here
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if sprite.get_rect().has_point(to_local(event.position)):
			get_parent().remove_child(self)
			wall_manager.request_rebake()
			queue_free()

func set_wall_manager(manager: Wall_Manager):
	wall_manager = manager
class_name Wall_Manager
extends Node2D

@export var nav_region:NavigationRegion2D = null

var wall_scene = preload("res://scene/wall.tscn")
var rebake_nav: bool = false
var bake_timer: float = 0.0

func _ready() -> void:
	if nav_region == null:
		nav_region = $NavigationRegion2D

func _input(event: InputEvent) -> void:
	#create a wall if there is a click-event
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			create_wall_at_position(event.global_position)

func _physics_process(delta: float) -> void:
	if rebake_nav:
		bake_timer += delta
		if bake_timer >= 0.1:  # Wait 0.1 seconds before baking
			nav_region.bake_navigation_polygon()
			rebake_nav = false
			bake_timer = 0.0


func create_wall_at_position(pos: Vector2) -> void:
	# Load the wall scene
	var wall_instance = wall_scene.instantiate()
	
	# Set the wall position to the click position
	wall_instance.global_position = pos
	
	# Add the wall to the NavigationRegion2D instead of this node
	nav_region.add_child(wall_instance)

	# Bake the navigation mesh to update pathfinding
	if nav_region and nav_region.navigation_polygon:
		rebake_nav = true

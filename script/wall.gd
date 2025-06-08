extends Node2D

@onready var obstacle = $NavigationObstacle2D

func _ready() -> void:
	obstacle.avoidance_enabled = true
	obstacle.avoidance_layers = 1
	# Make sure the obstacle has a proper radius
	if obstacle.radius <= 0:
		obstacle.radius = 100.0

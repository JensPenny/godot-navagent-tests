extends Node2D

@onready var obstacle = $NavigationObstacle2D

func _ready() -> void:
	obstacle.avoidance_enabled = true
	obstacle.avoidance_layers = 1
	# The obstacle uses vertices (polygon shape) defined in the scene
	# No need to set radius as it's using a custom polygon shape

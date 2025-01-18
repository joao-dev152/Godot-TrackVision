extends Area2D

@export var camera : TrackVision2D = null
@export var object : Node = null

func _on_body_entered(body: Node2D) -> void:
	camera.movement_camera(0.5, Vector2(369, 332), "play", object, 1.0)

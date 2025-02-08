extends Area2D

@export var camera : TrackVision2D = null

func _on_body_entered(body: Node2D) -> void:
	camera.spin_camera(360)

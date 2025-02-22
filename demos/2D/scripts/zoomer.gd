extends Area2D

@export var camera : TrackVision2D = null

func _on_body_entered(body: Node2D) -> void:
	camera.zoom_anim(0.5, Vector2(2.5, 2.5))

func _on_body_exited(body: Node2D) -> void:
	camera.zoom_anim(0.5, Vector2(1.5, 1.5))

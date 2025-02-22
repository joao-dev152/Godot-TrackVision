@icon("res://addons/TrackVision/assets/icon_3D.png")
@tool
extends Camera3D
class_name TrackVisionFixed3D

@export var target :Node3D = null
@export var follow_target_spin_x := true
@export var follow_target_spin_y := true
@export var follow_target_spin_z := true

func _ready() -> void:
	if Engine.is_editor_hint():
		print("I'm running inside the editor")
	else:
		print("I'm running inside the game")

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	
	if target == null:
		warnings.append("TrackVisionFixed3D needs a target to move the camera. You can select any type of Node3D in your scene to move the camera towards it.To select the target use the target property in the inspector.")
	
	return warnings

func _physics_process(delta: float) -> void:
	if target != null:
		global_position = target.global_position
		if follow_target_spin_x:
			global_rotation.x = target.global_rotation.x
		elif follow_target_spin_y:
			global_rotation.y = target.global_rotation.y
		elif follow_target_spin_z:
			global_rotation.z = target.global_rotation.z

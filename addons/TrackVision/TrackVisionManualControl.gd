@icon("res://addons/TrackVision/assets/icon_2D.png")
@tool
extends Camera2D
class_name TrackVisionManualControl

@export_group("Inputs")
@export var left_input := &"ui_left"
@export var right_input := &"ui_right"
@export var up_input := &"ui_up"
@export var down_input := &"ui_down"
@export_group("Movement")
@export var move_speed := 32.0
@export var weight := 0.2

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed(left_input):
		global_position.x -= lerp(move_speed, move_speed, weight)
	elif Input.is_action_pressed(right_input):
		global_position.x += lerp(move_speed, move_speed, weight)
	elif Input.is_action_pressed(up_input):
		global_position.y -= lerp(move_speed, move_speed, weight)
	elif Input.is_action_pressed(down_input):
		global_position.y += lerp(move_speed, move_speed, weight)

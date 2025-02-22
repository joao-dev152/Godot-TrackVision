@icon("res://addons/TrackVision/assets/icon_3D.png")
@tool
extends Node3D
class_name TrackVision3D

@export_group("Properties")
@export var target: Node3D
@export var camera: Camera3D

@export_group("Zoom")
@export var zoom_minimum = 16
@export var zoom_maximum = 4
@export var zoom_speed = 10
@export var enable_zoom_scroll := true

@export_group("Rotation")
@export var rotation_speed = 120

@export_group("Inputs")
@export var camera_left_input := &""
@export var camera_right_input := &""
@export var camera_up_input := &""
@export var camera_down_input := &""
@export var zoom_in_input := &""
@export var zoom_out_input := &""

var camera_rotation:Vector3
var zoom = 10


func _ready():
	if camera != null:
		camera_rotation = rotation_degrees # Initial rotation
		
		pass

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	
	if target == null:
		warnings.append("TrackVision3D needs a target to move the camera. You can select any type of Node3D in your scene to move the camera towards it.To select the target use the target property in the inspector")
	elif camera == null:
		warnings.append("TrackVision3D needs a camera to work. You can select an Camera3D with the property camera in the inspector.")
	
	return warnings

func _physics_process(delta):
	if camera != null:
		# Set position and rotation to targets
		
		self.position = self.position.lerp(target.position, delta * 4)
		rotation_degrees = rotation_degrees.lerp(camera_rotation, delta * 6)
		
		
		camera.position = camera.position.lerp(Vector3(0, 0, zoom), 8 * delta)
		
		handle_input(delta)

# Handle input

func handle_input(delta):
	if camera != null:
		# Rotation
		
		var input := Vector3.ZERO
		
		input.y = Input.get_axis(camera_left_input, camera_right_input)
		input.x = Input.get_axis(camera_up_input, camera_down_input)
		
		camera_rotation += input.limit_length(1.0) * rotation_speed * delta
		camera_rotation.x = clamp(camera_rotation.x, -80, -10)
		
		# Zooming
		
		zoom += Input.get_axis(zoom_in_input, zoom_out_input) * zoom_speed * delta
		zoom = clamp(zoom, zoom_maximum, zoom_minimum)

func _input(event: InputEvent) -> void:
	if enable_zoom_scroll:
		if event is InputEventMouseButton:
			if event.is_pressed():
				if event.button_index == MOUSE_BUTTON_WHEEL_UP:
					zoom -= lerpf(zoom, zoom_speed, 0.1)
				elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
					zoom += lerpf(zoom, zoom_speed, 0.1)
				zoom = clamp(zoom, zoom_maximum, zoom_minimum)

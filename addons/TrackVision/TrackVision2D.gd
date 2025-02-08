@tool
class_name TrackVision2D
extends Camera2D

@export var target : Node2D = null
@export var move_x := true
@export var move_y := true
@export var min_pos := Vector2.ZERO
@export var max_pos := Vector2.ZERO

var follow_player := true

func _ready() -> void:
	if Engine.is_editor_hint():
		print("I'm running inside the editor")
	else:
		print("I'm running inside the game")
	if  target != null:
		global_position = target.global_position

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	
	if target == null:
		warnings.append("TrackVision2D needs a target to move the camera. You can select any type of Node2D in your scene to move the camera towards it.To select the target use the target property in the inspector")
	
	return warnings

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if target != null and follow_player:
		if move_x:
			global_position.x = target.global_position.x
		if move_y:
			global_position.y = target.global_position.y
	if min_pos != Vector2.ZERO and max_pos != Vector2.ZERO:
		global_position = clamp(global_position, min_pos, max_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target == null:
		update_configuration_warnings()
	else:
		update_configuration_warnings()

func zoom_anim(duration : float, to : Vector2, from = Vector2.ZERO):
	var zoom_tween = create_tween()
	
	if from != Vector2.ZERO:
		zoom_tween.tween_property(self, "zoom", to, duration).from(from)
	else:
		zoom_tween.tween_property(self, "zoom", to, duration)

func movement_camera(duration : float, to : Vector2, call : String = "", object : Node = null, wait_time : float = 1.0, from = Vector2.ZERO):
	var movement_tween = create_tween().set_ease(Tween.EASE_IN)
	
	target.set_physics_process(false)
	target.set_process(false)
	
	follow_player = false
	
	if from != Vector2.ZERO:
		movement_tween.tween_property(self, "global_position", to, duration).from(from)
	else:
		movement_tween.tween_property(self, "global_position", to, duration)
	
	await movement_tween.finished
	
	if call != "" and object != null:
		object.call_deferred(call)
		await get_tree().create_timer(wait_time).timeout
	
	var back_movement_tween = create_tween().set_ease(Tween.EASE_OUT)
	
	back_movement_tween.tween_property(self, "global_position", target.global_position, duration)
	
	await back_movement_tween.finished
	
	follow_player = true
	
	target.set_physics_process(true)
	target.set_process(true)

func spin_camera(to : float, duration : float = 0.5, from : float = 0):
	ignore_rotation = false
	var spin_tween = create_tween()
	if from != 0:
		spin_tween.tween_property(self, "rotation", to, duration)
	else:
		spin_tween.tween_property(self, "rotation", to, duration).from(from)

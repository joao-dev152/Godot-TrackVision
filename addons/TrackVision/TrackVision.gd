@tool
extends EditorPlugin


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	print("res://addons/TrackVision/plugin.cfg plugin is enabled")

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	print("res://addons/TrackVision/plugin.cfg plugin is disabled")

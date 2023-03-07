extends Node

onready var current_level_name = GlobalWorld.world_name
var current_level = str("res://", current_level_name, ".tscn")


func handle_level_changed(current_level_name):
	var next_level_name = SceneChangeTrigger.next_level
	var next_level = str("res://", next_level_name, ".tscn")
	add_child(next_level)
	current_level.queue_free()
	current_level = next_level



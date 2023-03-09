extends Node


var next_level
var next_level_name: String
var current_level_name = GlobalWorld.world_name
onready var current_level = load(current_level_name + ".tscn")

func _ready() -> void:
	add_child(current_level)

func handle_level_changed(current_level_name: String):
	next_level = load(next_level_name + ".tscn").instance()
	add_child(next_level)
	get_child(current_level).queue_free()
	current_level = next_level


extends Node


var next_level
var next_level_name: String
var current_level_name = GlobalWorld.world_name
var current_level = load(str(current_level_name, ".tscn"))

func _ready() -> void:
	current_level = load(current_level_name + ".tscn")
	print(current_level)

func level_changed():
	next_level = load(next_level_name + ".tscn").instance()
	add_child(next_level)
	get_node("Starting Cave").queue_free()
	current_level = next_level


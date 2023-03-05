extends Node2D

var world_name = GlobalWorld.world_name
export var scene_changed = false

func _ready():
	if get_tree().change_scene()
		scene_changed = true

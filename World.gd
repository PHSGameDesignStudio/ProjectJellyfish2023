extends Node2D

signal world_changed(world_name)
var entered = false

export (String) var world_name = "World"

#func _process(delta):
	#if entered:
		
		#emit_signal("world_changed", world_name)
#
#func _on_Area2D_body_entered(body):
#	if (body.name == "NewSceneArea"):
#		get_tree().change_scene("res://Sea Cave 1.tscn")
#		entered = true
#func _on_Area2D_body_exited(body):
#	if (body.name == "NewSceneArea"):
#		entered = false


func _on_SceneTrigger_body_entered(body):
	pass # Replace with function body.

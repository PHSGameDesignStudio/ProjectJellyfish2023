extends Node2D

signal world_changed(world_name)
var entered = false

export (String) var world_name = "World"


func _ready():
	var cam = get_node("Player/Camera2D")
	if world_name == "Starting Cave":
		var map_limits = get_node("TileMapStartingCave").get_used_rect()
		var map_cellsize = get_node("TileMapStartingCave").cell_size
		cam.zoom.x = 0.5
		cam.zoom.y = 0.575
		cam.limit_left = map_limits.position.x  * map_cellsize.x
		cam.limit_top = map_limits.position.y * map_cellsize.y
		cam.limit_right = map_limits.end.x * map_cellsize.x
		cam.limit_bottom = map_limits.end.y * map_cellsize.y
	elif world_name == "Sea Cave 1":
		var map_limits = get_node("SeaCave1TileMap").get_used_rect()
		var map_cellsize = get_node("SeaCave1TileMap").cell_size
		cam.zoom.x = 1
		cam.zoom.y = 1
		cam.limit_left = map_limits.position.x  * map_cellsize.x
		cam.limit_top = map_limits.position.y * map_cellsize.y
		cam.limit_right = map_limits.end.x * map_cellsize.x
		cam.limit_bottom = map_limits.end.y * map_cellsize.y
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

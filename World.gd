extends Node2D

export (String) var world_name = name
onready var next_level = "Sea Cave 1.tscn"
onready var current_level = str(world_name, ".tscn")

func scene_change():
	SceneChangePlayer.play("SceneChangeFade")
	queue_free()
	get_tree().change_scene(next_level)
	current_level = next_level
	print("scene changed")

func _ready():
	current_level = "Starting Cave.tscn"
	next_level = "Sea Cave 1.tscn"
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
	elif world_name == "Amon's Cave":
		var map_limits = get_node("TileMapAmon'sCave").get_used_rect()
		var map_cellsize = get_node("TileMapAmon'sCave").cell_size
		cam.zoom.x = 0.1
		cam.zoom.y = 0.1
		cam.limit_left = map_limits.position.x  * map_cellsize.x
		cam.limit_top = map_limits.position.y * map_cellsize.y
		cam.limit_right = map_limits.end.x * map_cellsize.x
		cam.limit_bottom = map_limits.end.y * map_cellsize.y




func _on_To_Amons_Cave_body_entered(body):
	if body.name == "Player":
		next_level = "Amon's Cave.tscn"
		scene_change()


func _on_To_Starting_Cave_body_entered(body):
	if body.name == "Player":
		next_level = "Starting Cave.tscn"
		scene_change()


func _on_To_Sea_Cave_1_body_entered(body):
	if body.name == "Player":
		next_level = "Sea Cave 1.tscn"
		scene_change()


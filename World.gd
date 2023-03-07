extends Node2D

export (String) var world_name = name
onready var next_level_name 
onready var current_level_name = world_name
onready var current_level = str("res://", current_level_name, ".tscn")
onready var next_level = str("res://", next_level_name, ".tscn")


func handle_level_changed(current_level_name):
	load(next_level)
	current_level_name = next_level_name
	
func scene_change():
	SceneChangePlayer.play("SceneChangeFade")
	handle_level_changed(current_level_name)

func _ready():
	current_level_name = "Starting Cave"
	next_level_name = "Sea Cave 1"
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
	next_level_name = "Amon's Cave"
	scene_change()


func _on_To_Starting_Cave_body_entered(body):
	next_level_name = "Starting Cave"
	scene_change()


func _on_To_Sea_Cave_1_body_entered(body):
	next_level_name = "Sea Cave 1"
	print(next_level)
	scene_change()


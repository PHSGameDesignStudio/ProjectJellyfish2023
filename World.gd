extends Node2D

export (String) var world_name = name
onready var next_level_name = "Sea Cave 1"
onready var current_level_name = world_name
onready var current_level = str(current_level_name)
onready var next_level = str(next_level_name)

	
func scene_change():
	var sceneChangePlayer : AnimationPlayer = get_viewport().get_node("SceneChangePlayer");
	sceneChangePlayer.play("SceneChangeFade")
	yield(get_tree().create_timer(sceneChangePlayer.current_animation_length / 2.0), "timeout")
	get_tree().change_scene(next_level_name)
	current_level_name = next_level_name
	

func _ready():
	#Player.global_transform(Vector2(1,11))
	var cam = $Player/Camera2D
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
	next_level_name = "Starting Cave.tscn"
	scene_change()


func _on_To_Sea_Cave_1_body_entered(body):
	next_level_name = "res://Sea Cave 1.tscn"
	print(next_level)
	scene_change()



func _on_Transition_Timer_timeout():
	pass
	#get_tree().change_scene(next_level_name)
	#current_level_name = next_level_name

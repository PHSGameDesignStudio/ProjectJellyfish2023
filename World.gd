extends Node2D

export (String) var world_name = name
var to_scene
var from_scene

signal player_position

func scene_change():
	from_scene = world_name
	var sceneChangePlayer : AnimationPlayer = get_viewport().get_node("SceneChangePlayer");
	sceneChangePlayer.play("SceneChangeFade")
	yield(get_tree().create_timer(sceneChangePlayer.current_animation_length / 2.0), "timeout")
	get_tree().change_scene(to_scene)
	

func _ready():
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
		cam.zoom.x = 0.5
		cam.zoom.y = 0.575
		cam.limit_left = map_limits.position.x  * map_cellsize.x
		cam.limit_top = map_limits.position.y * map_cellsize.y
		cam.limit_right = map_limits.end.x * map_cellsize.x
		cam.limit_bottom = map_limits.end.y * map_cellsize.y




func _on_To_Amons_Cave_body_entered(body):
	if body.name == "Player":
		to_scene = "Amon's Cave.tscn"
		scene_change()


func _on_To_Starting_Cave_body_entered(body):
	if body.name == "Player":
		to_scene = "Starting Cave.tscn"
		scene_change()
		Player.position == get_node("To Sea Cave 1/CollisionShape2D").position


func _on_To_Sea_Cave_1_body_entered(body):
	if body.name == "Player":
		to_scene = "Sea Cave 1.tscn"
		scene_change()
		emit_signal("player_position")




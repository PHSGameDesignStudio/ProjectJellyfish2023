extends Node2D

var curr_scene = "Starting Cave"
onready var globals = preload("res://GlobalResource.tres")


func _ready():
	print("New scene instance!")
	
	var map_limits
	var map_cellsize
	var cam = $Player/Camera2D
	var matching_scene_trigger = globals.matching_scene_trigger
	
	curr_scene = get_tree().get_current_scene().get_name()
	
	if curr_scene == "Starting Cave":
		map_limits = get_node("TileMapStartingCave").get_used_rect()
		map_cellsize = get_node("TileMapStartingCave").cell_size
		cam.zoom.x = 0.5
		cam.zoom.y = 0.575
	elif curr_scene == "Sea Cave 1":
		map_limits = get_node("SeaCave1TileMap").get_used_rect()
		map_cellsize = get_node("SeaCave1TileMap").cell_size
		cam.zoom.x = 1
		cam.zoom.y = 1
	elif curr_scene == "Amon's Cave":
		map_limits = get_node("TileMapAmon'sCave").get_used_rect()
		map_cellsize = get_node("TileMapAmon'sCave").cell_size
		cam.zoom.x = 0.5
		cam.zoom.y = 0.575
	else:
		pass
	
	cam.limit_left = map_limits.position.x  * map_cellsize.x
	cam.limit_top = map_limits.position.y * map_cellsize.y
	cam.limit_right = map_limits.end.x * map_cellsize.x
	cam.limit_bottom = map_limits.end.y * map_cellsize.y
	
	var scene_trigger = get_node(matching_scene_trigger)
	# FIXME: this check is probably indicative of poor design
	if scene_trigger != null:
		var position = scene_trigger.get_child(0).global_position
		var mid_x = (cam.limit_right - cam.limit_left) / 2
		var dev_x = (position.x - mid_x) / mid_x
		if dev_x > 0:
			position.x -= 100
			$Player.global_position = position
		elif dev_x < 0:
			position.x += 100
			$Player.global_position = position
	else:
		pass
	
	register_scene_triggers()

func _notification(notif: int):
	match notif:
		MainLoop.NOTIFICATION_WM_QUIT_REQUEST, MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			# FIXME: probably a cleaner way to do this
			globals.matching_scene_trigger = ""
			ResourceSaver.save("res://GlobalResource.tres", globals)
		_:
			pass

func check_scene_change(colliding_body, scene_trigger):
	if colliding_body.name == "Player":
		scene_change(scene_trigger.get_name())

func scene_change(scene_trigger):
	var sceneChangePlayer: AnimationPlayer = get_viewport().get_node("SceneChangePlayer");
	sceneChangePlayer.play("SceneChangeFade")
	yield(get_tree().create_timer(sceneChangePlayer.current_animation_length / 2.5), "timeout")
	
	var next_scene
	match scene_trigger.rfind("(") - 1:
		-2:
			next_scene = scene_trigger.substr(3)
		var n:
			next_scene = scene_trigger.substr(3, n - 3)
	var next_scene_path = str(next_scene, ".tscn")
	var matching_scene_trigger = scene_trigger.replace(next_scene, curr_scene)
	globals.matching_scene_trigger = matching_scene_trigger
	ResourceSaver.save("res://GlobalResource.tres", globals)
	
	get_tree().change_scene(next_scene_path)

# has to be manually updated... (FIXME?)
func register_scene_triggers():
	var scene_trigger
	
	# looking like yandev right now :(
	# ideal: find a better way to coalesce signals
	if curr_scene == "Starting Cave":
		scene_trigger = get_node("To Sea Cave 1")
		scene_trigger.connect("body_entered", self, "check_scene_change", [scene_trigger])
	elif curr_scene == "Sea Cave 1":
		scene_trigger = get_node("To Starting Cave")
		scene_trigger.connect("body_entered", self, "check_scene_change", [scene_trigger])
		scene_trigger = get_node("To Amon's Cave")
		scene_trigger.connect("body_entered", self, "check_scene_change", [scene_trigger])
	elif curr_scene == "Amon's Cave":
		scene_trigger = get_node("To Sea Cave 1")
		scene_trigger.connect("body_entered", self, "check_scene_change", [scene_trigger])
	else:
		pass

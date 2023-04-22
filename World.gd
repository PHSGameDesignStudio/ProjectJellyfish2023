extends Node2D

onready var world = get_tree().get_current_scene()
onready var curr_scene = self
onready var player = world.get_node("Player")
onready var globals = preload("res://GlobalResource.tres")


func _ready():
	curr_scene = world.get_child(2)
	print("\nNew scene instance! (", curr_scene.get_name(), ")\n")
	
	if globals.matching_scene_trigger != "":
		var scene_trigger = curr_scene.get_node(globals.matching_scene_trigger)
		if scene_trigger != null:
			player.global_position = scene_trigger.get_node("Position2D").global_position
	elif curr_scene.get_name() == "Starting Cave":
		var start_position = curr_scene.get_node("PlayerStart")
		player.global_position = start_position.global_position
	else:
		get_tree().quit()
	
	globals.matching_scene_trigger = ""
	ResourceSaver.save("res://GlobalResource.tres", globals)
	
	var cam = player.get_node("Camera2D")
	
	if curr_scene.get_name() == "Starting Cave":
		cam.zoom.x = 0.5
		cam.zoom.y = 0.575
	elif curr_scene.get_name() == "Sea Cave 1":
		cam.zoom.x = 1
		cam.zoom.y = 1
	elif curr_scene.get_name() == "Amon's Cave":
		cam.zoom.x = 0.5
		cam.zoom.y = 0.575
	elif curr_scene.get_name() == "Sea Cave 2":
		cam.zoom.x = 1
		cam.zoom.y = 1
	else:
		get_tree().quit()
	
	var tile_map = curr_scene.get_node("Tile Map")
	var map_limits = tile_map.get_used_rect()
	var map_cellsize = tile_map.cell_size
		
	cam.limit_left = map_limits.position.x  * map_cellsize.x
	cam.limit_top = map_limits.position.y * map_cellsize.y
	cam.limit_right = map_limits.end.x * map_cellsize.x
	cam.limit_bottom = map_limits.end.y * map_cellsize.y
	
	register_scene_triggers()
	yield(get_tree().create_timer(0.001), "timeout")
	player.get_node("CollisionShape2D").disabled = false

func _notification(notif: int):
	match notif:
		MainLoop.NOTIFICATION_WM_QUIT_REQUEST, MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			globals.matching_scene_trigger = ""
			ResourceSaver.save("res://GlobalResource.tres", globals)
		_:
			pass

func on_scene_trigger_entered(colliding_body, scene_trigger):
	print("Entered: ", scene_trigger.get_name(), " < ", colliding_body.get_name())
	if colliding_body.name == "Player":
		scene_change(scene_trigger.get_name())

func scene_change(scene_trigger):
	var sceneChangePlayer = world.get_node("SceneChangePlayer")
	sceneChangePlayer.play("SceneChangeFade")
	yield(get_tree().create_timer(0.3), "timeout")
	
	var next_scene
	match scene_trigger.rfind("(") - 1:
		-2:
			next_scene = scene_trigger.substr(3)
		var n:
			next_scene = scene_trigger.substr(3, n - 3)

	globals.matching_scene_trigger = scene_trigger.replace(next_scene, curr_scene.get_name())
	ResourceSaver.save("res://GlobalResource.tres", globals)
	
	player.get_node("CollisionShape2D").disabled = true
	world.remove_child(world.get_node(curr_scene.get_name()))
	var next_scene_packed = load(str(next_scene, ".tscn")).instance()
	world.add_child_below_node(world.get_node("SceneChangePlayer"), next_scene_packed)

func register_scene_triggers():
	var scene_triggers = get_tree().get_nodes_in_group("Scene Trigger")
	
	for scene_trigger in scene_triggers:
		scene_trigger.connect("body_entered", self, "on_scene_trigger_entered", [scene_trigger])

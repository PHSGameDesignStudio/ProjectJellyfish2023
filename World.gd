extends Node2D

onready var world = get_tree().get_current_scene()
export var curr_scene = ""
export var matching_scene_trigger = ""
onready var player = world.get_node("Player")
onready var globals = preload("res://GlobalResource.tres")


func _ready():
	curr_scene = world.get_child(2)
	print("New scene instance! (", curr_scene.get_name(), ")")
	var top_level_nodes = world.get_children()
	for node in top_level_nodes:
		print("Top level nodes: ", node.get_name())
	
	var map_limits
	var map_cellsize
	var cam = player.get_node("Camera2D")
	
	matching_scene_trigger = globals.matching_scene_trigger
	globals.matching_scene_trigger = ""
	ResourceSaver.save("res://GlobalResource.tres", globals)
	
	player.set_animation(globals.player_anim)
	
	if curr_scene.get_name() == "Starting Cave":
		map_limits = curr_scene.get_node("TileMapStartingCave").get_used_rect()
		map_cellsize = curr_scene.get_node("TileMapStartingCave").cell_size
		cam.zoom.x = 0.5
		cam.zoom.y = 0.575
	elif curr_scene.get_name() == "Sea Cave 1":
		map_limits = curr_scene.get_node("SeaCave1TileMap").get_used_rect()
		map_cellsize = curr_scene.get_node("SeaCave1TileMap").cell_size
		cam.zoom.x = 1
		cam.zoom.y = 1
	elif curr_scene.get_name() == "Amon's Cave":
		map_limits = curr_scene.get_node("TileMapAmon'sCave").get_used_rect()
		map_cellsize = curr_scene.get_node("TileMapAmon'sCave").cell_size
		cam.zoom.x = 0.5
		cam.zoom.y = 0.575
	else:
		pass
	
	cam.limit_left = map_limits.position.x  * map_cellsize.x
	cam.limit_top = map_limits.position.y * map_cellsize.y
	cam.limit_right = map_limits.end.x * map_cellsize.x
	cam.limit_bottom = map_limits.end.y * map_cellsize.y
	
	if matching_scene_trigger != "":
		var scene_trigger = curr_scene.get_node(matching_scene_trigger)
		# FIXME: this check is probably indicative of poor design
		if scene_trigger != null:
			print(scene_trigger)
			var position = scene_trigger.get_child(1).global_position
			player.global_position = position
	else:
		var start_position = curr_scene.get_node("PlayerStart")
		player.global_position = start_position.global_position
	
	register_scene_triggers()

func _notification(notif: int):
	match notif:
		MainLoop.NOTIFICATION_WM_QUIT_REQUEST, MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			# FIXME: probably a cleaner way to do this
			globals.matching_scene_trigger = ""
			globals.player_anim = 3
			ResourceSaver.save("res://GlobalResource.tres", globals)
		_:
			pass

func on_scene_trigger_entered(colliding_body, scene_trigger):
	print("Entered: ", scene_trigger.get_name(), " < ", colliding_body.get_name())
	if colliding_body.name == "Player":
		scene_change(scene_trigger.get_name())

func scene_change(scene_trigger):
	#var sceneChangePlayer: AnimationPlayer = get_viewport().get_node("SceneChangePlayer");
	var sceneChangePlayer = world.get_node("SceneChangePlayer")
	sceneChangePlayer.play("SceneChangeFade")
	yield(get_tree().create_timer(0.3), "timeout")
	
	var next_scene
	match scene_trigger.rfind("(") - 1:
		-2:
			next_scene = scene_trigger.substr(3)
		var n:
			next_scene = scene_trigger.substr(3, n - 3)

	matching_scene_trigger = scene_trigger.replace(next_scene, curr_scene.get_name())
	globals.matching_scene_trigger = matching_scene_trigger
	globals.player_anim = player.get_animation()
	ResourceSaver.save("res://GlobalResource.tres", globals)
	
	world.remove_child(world.get_child(1))
	var next_scene_packed = load(str(next_scene, ".tscn"))
	world.add_child_below_node(world.get_node("SceneChangePlayer"), next_scene_packed.instance())

# ?FIXME: scene triggers have to be manually given group "Scene Trigger"
# can this be more streamlined?!?!
func register_scene_triggers():
	var scene_triggers = get_tree().get_nodes_in_group("Scene Trigger")
	
	for scene_trigger in scene_triggers:
		scene_trigger.connect("body_entered", self, "on_scene_trigger_entered", [scene_trigger])

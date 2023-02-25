extends Node

var next_world
onready var current_world = $"Starting Cave"
onready var anim = $AnimationPlayer

func _ready() -> void:
	current_world.connect("world_changed", self, "handle_world_changed")
	
	
func handle_world_changed(current_world_name: String):
	var next_world_name: String
	match(current_world_name):
		"Starting Cave":
			next_world_name = "Sea Cave 1"
		"Sea Cave 1":
			next_world_name = "Starting Cave"
		_:
			return
	next_world = load("res://" + next_world_name + ".tscn").instance()
	next_world.z_index = -1
	add_child(next_world)
	anim.play("fade_in")
	next_world.connect("world_changed", self, "handle_world_changed")

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"fade_in":
			current_world.queue_free()
			current_world = next_world
			current_world.z_index = 0
			next_world = null
			anim.play("fade_out")

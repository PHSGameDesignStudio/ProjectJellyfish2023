extends Area2D


export (String) var currentScene = GlobalWorld.world_name
export (String) var nextScene = "Sea Cave 1.tscn";
onready var anim_player = $"SceneChangePlayer"

func _ready():
	if $"/root/ProjectJellyfish".scene_changed:
		anim_player.play("FadeIn")
		anim_player.play("FadeOut")
		yield(anim_player, "animation_finished")
		$"/root/ProjectJellyfish".scene_changed = false

func _on_SceneTrigger_body_entered(body):
	if (body.name == "Player"):
		var tree = get_tree()
		$"/root/ProjectJellyfish".scene_changed = true
		tree.change_scene(nextScene)
			

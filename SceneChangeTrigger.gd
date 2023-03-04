extends Area2D

onready var anim_player = $SceneChangePlayer

func _ready():
	if $"/root/ProjectJellyfish".scene_changed:
		anim_player.play("FadeIn")
		anim_player.play("FadeOut")
		yield(anim_player, "animation_finished")
		$"/root/ProjectJellyfish".scene_changed = false
			
func _on_To_Amons_Cave_body_entered(body):
	if (body.name == "Player"):
		var tree = get_tree()
		$"/root/ProjectJellyfish".scene_changed = true
		tree.change_scene("res://Amon's Cave.tscn")


func _on_To_Sea_Cave_1_body_entered(body):
	if (body.name == "Player"):
		var tree = get_tree()
		$"/root/ProjectJellyfish".scene_changed = true
		tree.change_scene("res://Sea Cave 1.tscn")


func _on_To_Starting_Cave_body_entered(body):
	if (body.name == "Player"):
		var tree = get_tree()
		$"/root/ProjectJellyfish".scene_changed = true
		tree.change_scene("res://Starting Cave.tscn")

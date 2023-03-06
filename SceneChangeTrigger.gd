extends Area2D

onready var anim_player = $SceneChangePlayer

var scene_name = ""
func _process(_delta):
	pass

func scene_change(_scene_name):
	scene_name = _scene_name
	anim_player.play("FadeOut")
	#yield(anim_player, "animation_finished")
	#anim_player.play("FadeOut")
	#yield(anim_player, "animation_finished")
	#get_tree().change_scene(scene_name)

func _on_To_Amons_Cave_body_entered(body):
	if (body.name == "Player"):
		scene_change("res://Amon's Cave.tscn")


func _on_To_Sea_Cave_1_body_entered(body):
	if (body.name == "Player"):
		scene_change("res://Sea Cave 1.tscn")


func _on_To_Starting_Cave_body_entered(body):
	if (body.name == "Player"):
		scene_change("res://Starting Cave.tscn")

func _on_SceneChangePlayer_animation_finished(anim_name):
	get_tree().change_scene(scene_name)

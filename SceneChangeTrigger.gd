extends Area2D


export var nextScene = "";
onready var anim_player = $SceneChangePlayer


func _on_SceneTrigger_body_entered(body):
	if (body.name == "Player"):
		anim_player.play("SceneChangeFade")
		yield(anim_player, "animation_finished")
		get_tree().change_scene(nextScene)

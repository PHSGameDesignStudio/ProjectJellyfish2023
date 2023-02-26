extends Area2D

var entered = false
export var nextScene = "";
func _process(delta):
	pass
	#if entered == true:
		#get_tree().change_scene("res://Sea Cave 1.tscn")
	


func _on_SceneTrigger_body_entered(body):
	if (body.name == "Player"):
		get_tree().change_scene(nextScene)

extends Area2D

var file_name = str("res://", ".tscn")

	
func _ready():
	pass
	

func _process(_delta):
	pass

func scene_change():
	SceneChangePlayer.play("SceneChangeFade")
	print(file_name)
	get_tree().change_scene(file_name)
	
	
func _on_To_Amons_Cave_body_entered(body):
	if (body.name == "Player"):
		scene_change()


func _on_To_Sea_Cave_1_body_entered(body):
	if (body.name == "Player"):
		scene_change()


func _on_To_Starting_Cave_body_entered(body):
	if (body.name == "Player"):
		scene_change()


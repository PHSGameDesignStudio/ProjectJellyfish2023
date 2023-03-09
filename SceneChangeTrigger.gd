extends Area2D

var current_level_name = GlobalWorld.world_name


func _on_To_Sea_Cave_1_body_entered(body):
	SceneSwitcher.next_level_name = "Sea Cave 1"
	SceneSwitcher.handle_level_changed(current_level_name)


func _on_To_Amons_Cave_body_entered(body):
	SceneSwitcher.next_level_name = "Amon's Cave"
	SceneSwitcher.handle_level_changed(current_level_name)


func _on_To_Starting_Cave_body_entered(body):
	SceneSwitcher.next_level_name = "Starting Cave"
	SceneSwitcher.handle_level_changed(current_level_name)

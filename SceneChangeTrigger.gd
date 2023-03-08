extends Area2D



func _on_To_Sea_Cave_1_body_entered(body):
	SceneSwitcher.next_level_name = "Sea Cave 1"
	SceneSwitcher.level_changed()


func _on_To_Amons_Cave_body_entered(body):
	SceneSwitcher.next_level_name = "Amon's Cave"
	SceneSwitcher.level_changed()


func _on_To_Starting_Cave_body_entered(body):
	SceneSwitcher.next_level_name = "Starting Cave"
	SceneSwitcher.level_changed()

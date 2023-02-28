extends Node2D

signal scene_transition


func _on_Starting_Cave_scene_change():
	emit_signal("scene_transition")
